Before do
  $fail_on_js_error = true
end

# Check for async JS failures
After do |scenario|
  errors = browser_logs(:browser)
    .select { |log| log.level == 'SEVERE' }
    .map(&:message)

  next unless errors.any?
  messages = errors.join("\n")

  if $fail_on_js_error
    capture_error(scenario, StandardError.new(messages))
    raise "Detected JS errors:\n\n#{messages}"
  else
    log "Detected JS errors, but ignored them:\n\n#{messages}"
  end
end

# Check for failures (report to Sentry)
#
# Needs to be defined *after* the async JS hook so that it runs
# *first*. Otherwise we'll report the same exception twice.
After do |scenario|
  next unless scenario.exception
  capture_error(scenario, scenario.exception)
end

def browser_logs(type)
  Capybara
    .current_session
    .driver.browser
    .logs
    .get(type)
end

def capture_error(scenario, exception)
  Sentry.with_scope do |scope|
    # First line of the message becomes the issue title, which
    # we want to be the feature (file) to support drilling down.
    message = scenario.location.file + "\n\n" + exception.to_s

    # Adding the scenario supports further drill down using the
    # Sentry "tags" view. Substituting " is necessary for search.
    scope.set_tags('cucumber.scenario': scenario.name.gsub('"', "'"))

    # Using the feature (file) as the fingerprint means we only
    # get one issue per feature, keeping the dashboard simple.
    # The hint is used by govuk_app_config, which will emit stats
    # for the error class, in addition to what we get in Sentry.
    Sentry.capture_message(
      message,
      fingerprint: [scenario.location.file],
      backtrace: exception.backtrace,
      hint: { exception: exception }
    )
  end
end

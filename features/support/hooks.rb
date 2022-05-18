Before do
  $fail_on_js_error = true
end

# Check for failures (report to Sentry)
After do |scenario|
  next unless scenario.exception
  capture_error(scenario, scenario.exception)
end

# Check for async JS failures
After do
  errors = browser_logs(:browser)
    .select { |log| log.level == 'SEVERE' }
    .map(&:message)

  errors.each(&$stderr.puts)
  next unless errors.any?
  messages = errors.join("\n")

  if $fail_on_js_error
    capture_error(scenario, e)
    raise "Detected JS errors:\n\n#{messages}"
  else
    log "Detected JS errors, but ignored them:\n\n#{messages}"
  end
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

    # Adding the scenario supports further drill down within the
    # scenarios for a particular apps / functionality.
    scope.set_tags('cucumber.scenario': scenario.name)

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

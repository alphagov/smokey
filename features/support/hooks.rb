Before do
  # Manual HTTP requests will go to GOV.UK
  @host = Plek.new.website_root
  # "visit '/path'" will visit GOV.UK pages
  Capybara.app_host = @host
  # Cache bust by default so we check origin
  @bypass_caching = true

  $fail_on_js_error = true
  flush_chrome_logs
end

After do |scenario|
  # Scenario failed, so report the failure to Sentry
  if scenario.exception
    capture_error(scenario, scenario.exception)
    next
  end

  # Scenario passed, but could have async JS errors
  errors = browser_logs
    .select { |log| log.level == 'SEVERE' }
    .map(&:message)

  next unless errors.any?
  messages = errors.join("\n")

  if $fail_on_js_error
    capture_error(scenario, StandardError.new(messages), js:true)
    # This will change the scenario to be a failure
    raise "Detected JS errors:\n\n#{messages}"
  else
    log "Detected JS errors, but ignored them:\n\n#{messages}"
  end
end

def capture_error(scenario, exception, js: false)
  Sentry.with_scope do |scope|
    # First line of the message becomes the issue title, which
    # we want to be the feature (file) to support drilling down.
    message = scenario.location.file + "\n\n" + exception.to_s

    # Adding the scenario supports further drill down using the
    # Sentry "tags" view. Substituting " is necessary for search.
    GovukError.notify(
      message,
      backtrace: exception.backtrace,
      tags: {
        'cucumber.scenario': scenario.name.gsub('"', "'"),
        'cucumber.js_error': js
      }
    )
  end
end

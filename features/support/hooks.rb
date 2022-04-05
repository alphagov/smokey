require 'sentry-ruby'

Before do
  # Clear the request log so that tests only see their requests.
  $proxy.new_har(capture_binary_content: true)
  $fail_on_js_error = true
end

After do
  if $fail_on_js_error
    flush_and_check_errors
  else
    begin
      flush_and_check_errors
    rescue Capybara::Chromedriver::Logger::JsError => e
      puts "Detected JS error, but ignored it. #{e}"
    end
  end
end

After do |scenario|
  Sentry.init do |config|
    config.dsn = 'abc123'
    config.send_modules = false # list of installed gems
  end

  if scenario.exception
    Sentry.with_scope do |scope|
      scope.set_tags(
        'cucumber.scenario': scenario.name,
        'cucumber.failing_step': scenario.test_steps[-1].text
      )

      message = <<~HERE
        #{scenario.location.file}

        \t#{scenario.test_steps.reject(&:hook?).map(&:text).join("\n\t")}

        #{scenario.exception.to_s}
      HERE

      Sentry.capture_message(
        message,
        fingerprint: [scenario.location.file],
        backtrace: scenario.exception.backtrace,
      )
    end
  end
end

def flush_and_check_errors
  # Do this manually rather than using `after_example!` so we can configure
  # the log destination to be $stderr rather than $stdout. This prevents
  # unformatted JavaScript errors from making their way into the Smokey loop's
  # JSON output file and breaking it.
  collector = Capybara::Chromedriver::Logger::Collector.new(log_destination: $stderr)
  collector.flush_and_check_errors!
end

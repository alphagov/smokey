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

def flush_and_check_errors
  # Do this manually rather than using `after_example!` so we can configure
  # the log destination to be $stderr rather than $stdout. This prevents
  # unformatted JavaScript errors from making their way into the Smokey loop's
  # JSON output file and breaking it.
  collector = Capybara::Chromedriver::Logger::Collector.new(log_destination: $stderr)
  collector.flush_and_check_errors!
end

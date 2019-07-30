Before do
  # Clear the request log so that tests only see their requests.
  $proxy.new_har(capture_binary_content: true)
end

After do
  # Do this manually rather than using `after_example!` so we can configure
  # the log destination to be $stderr rather than $stdout. This prevents
  # unformatted JavaScript errors from making their way into the Smokey loop's
  # JSON output file and breaking it.
  collector = Capybara::Chromedriver::Logger::Collector.new(log_destination: $stderr)
  collector.flush_and_check_errors!
end

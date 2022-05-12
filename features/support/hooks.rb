Before do
  $fail_on_js_error = true
end

After do
  if $fail_on_js_error
    flush_and_check_errors
  else
    begin
      flush_and_check_errors
    rescue ChromeBrowserLog::JsError => e
      puts "Detected JS error, but ignored it. #{e}"
    end
  end
end

def flush_and_check_errors
  errors = browser_logs(:browser)
    .select { |log| log.level == 'SEVERE' }
    .map(&:message)

  errors.each(&$stderr.puts)
  return unless errors.any?

  raise ChromeBrowserLog::JsError,
    "Got some JS errors during testing:\n\n#{errors.join("\n")}"
end

class ChromeBrowserLog
  class JsError < StandardError; end
end

def browser_logs(type)
  Capybara
    .current_session
    .driver.browser
    .manage
    .logs
    .get(type)
end

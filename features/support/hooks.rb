Before do
  $fail_on_js_error = true
end

After do
  if $fail_on_js_error
    flush_and_check_errors
  else
    begin
      flush_and_check_errors
    rescue LogMessage::JsError => e
      puts "Detected JS error, but ignored it. #{e}"
    end
  end
end

def flush_and_check_errors
  errors = extract_errors
  return if errors.empty?

  formatted_errors = errors.map(&:to_s)
  error_list = formatted_errors.join("\n")

  raise LogMessage::JsError, "Got some JS errors during testing:\n\n#{error_list}"
end

def extract_errors
  errors = []

  logs(:browser).each do |log|
    message = LogMessage.new(log)
    next if should_filter?(message)

    errors << message if message.level == 'SEVERE'
    $stderr.puts(message.to_s)
  end

  errors
end

def should_filter?(message)
  %i[debug info warning].include?(message.level.downcase.to_sym)
end

def logs(type)
  Capybara
    .current_session
    .driver.browser
    .manage
    .logs
    .get(type)
end

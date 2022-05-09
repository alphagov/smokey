Before do
  $fail_on_js_error = true
end

After do
  errors = browser_logs(:browser)
    .select { |log| log.level == 'SEVERE' }
    .map(&:message)

  errors.each(&$stderr.puts)
  return unless errors.any?
  messages = errors.join("\n")

  if $fail_on_js_error
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

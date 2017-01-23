Then /^I should receive a "([a-z0-9_]+)" cookie which is "([a-zA-Z]+)"$/ do |cookie_name, cookie_property|
  header = page.response_headers['Set-Cookie']
  assert header.to_s.start_with?(cookie_name), "No cookie called #{cookie_name} is being set"

  property_matches = header.match /; #{cookie_property}(;|$)/
  assert !property_matches.nil?, "The cookie #{cookie_name} does not have property #{cookie_property}"
end

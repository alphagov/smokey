Then /^I should receive a "([a-z0-9_]+)" cookie which is "([a-zA-Z]+)"$/ do |cookie_name, cookie_property|
  browser = Capybara.current_session.driver.browser.manage
  cookie = browser.cookie_named(cookie_name)
  assert cookie, "No cookie called #{cookie_name} is being set"
  assert_equal true, cookie[cookie_property.to_sym], "The cookie #{cookie_name} does not have property #{cookie_property}"
end

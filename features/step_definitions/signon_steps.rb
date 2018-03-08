When /^I try to login as a user$/ do
  assert ENV["SIGNON_EMAIL"] && ENV["SIGNON_PASSWORD"], "Please ensure that the signon user credentials are available in the environment"

  visit application_external_url("signon")

  fill_in "Email", :with => ENV["SIGNON_EMAIL"]
  fill_in "Passphrase", :with => ENV["SIGNON_PASSWORD"]
  click_button "Sign in"
end

Then(/^I should be redirected to signon$/) do
  signon_url = application_external_url("signon")

  expect(page.current_url).to match(signon_url)
end

When /^I try to login as a user$/ do
  assert ENV["SIGNON_EMAIL"] && ENV["SIGNON_PASSWORD"], "Please ensure that the signon user credentials are available in the environment"

  visit signon_base_url

  fill_in "Email", :with => ENV["SIGNON_EMAIL"]
  fill_in "Passphrase", :with => ENV["SIGNON_PASSWORD"]
  click_button "Sign in"
end

When /^I try to access the list of lenders$/ do
  @response = get_request "#{efg_base_url}/lenders"
end

When /^I try to login as a lender user$/ do
  assert ENV["EFG_USERNAME"] && ENV["EFG_PASSWORD"], "Please ensure that the EFG user credentials are available in the environment"
  @response = post_request "#{efg_base_url}/users/sign_in", :payload => "user[username]=#{ENV["EFG_USERNAME"]}&user[password]=#{ENV["EFG_PASSWORD"]}"
end

When /^I visit the EFG home page$/ do
  get_request "#{efg_base_url}"
end

Then /^I should be on the EFG home page$/ do
  steps %Q{
    Then I should see "user_username"
    And I should see "user_password"
    And I should see "Sign In"
  }
end

Then /^I should be on the EFG lender user home page$/ do
  steps %Q{
    Then I should see "alert-success"
    And I should see "loan_alerts"
    And I should see "utilisation_dashboard"
  }
end

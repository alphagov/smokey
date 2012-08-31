When /^I try to access the list of lenders$/ do
  @response = get_request "#{efg_base_url}/lenders"
end

When /^I visit the EFG home page$/ do
  get_request "#{efg_base_url}"
end

Then /^I should be on the EFG home page$/ do
  @response.body.include?("Sign In")
end

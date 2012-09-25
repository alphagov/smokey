When /^I try to visit the contracts finder home page$/ do
  @response = get_request "https://www.contractsfinder.businesslink.gov.uk/"
end

Then /^I should be on the contracts finder home page$/ do
  @response.body.include?("Welcome").should == true
end

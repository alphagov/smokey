Then /^I should see an input field to search$/ do
  @response.body.should have_field('keywords')
end

Then /^I should see an input field to search$/ do
  page.body.should have_field('keywords')
end

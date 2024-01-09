Then /^I should see a populated country select$/ do
  # Check that we have a sensible-looking number of countries, with
  # some flex for that number to change
  expect(page).to have_css("#current-question select option", minimum: 200)
end

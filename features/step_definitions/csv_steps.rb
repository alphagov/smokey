Then /^JavaScript should run without any errors$/ do
  # If the `report-a-problem-toggle-wrapper` element exists then JavaScript
  # is running on the page and there are no SRI or similar errors
  expect(page).to have_selector('.report-a-problem-toggle-wrapper')
end

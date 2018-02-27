Then /^JavaScript should run without any errors$/ do
  # If the `js-enabled` class exists on the body then JavaScript
  # is running on the page and there are no SRI or similar errors
  expect(page).to have_selector('body.js-enabled')
end

Then /^JavaScript should run without any errors$/ do
  # If the `gem-c-feedback__prompt-link` element exists then JavaScript
  # is running on the page and there are no SRI or similar errors
  expect(page).to have_selector(".gem-c-feedback__prompt-link[aria-expanded='false']")
end

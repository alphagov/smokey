Then /^JavaScript should run without any errors$/ do
  # If the `gem-c-feedback__prompt-link` element exists and the
  # page displays the text 'Is there anything wrong with this page?'
  # then JavaScript is running on the page and there are no SRI or similar errors
  expect(page).to have_content("Is there anything wrong with this page?")
  expect(page).to have_selector(".gem-c-feedback__prompt-link[aria-expanded='false']")
end

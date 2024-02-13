When /^I add an artefact$/ do
  click_link "Add artefact"
  fill_in "Title", with: "Smokey Guide"
  fill_in "Slug", with: "smokey-guide"
  select "Guide", from: "Format"
  click_button "Save and go to item"
  expect(page).to have_selector("h1", text: "Smokey Guide")
end

When /^I delete the artefact$/ do
  click_link "Admin"
  click_button "Delete this edition – #1"
end

Then /^I should see that the edition has been deleted$/ do
  expect(page).to have_content("Edition deleted")
end

Then /^I should see Publisher's publication index$/ do
  expect(page).to have_selector("#publication-list-container")
end

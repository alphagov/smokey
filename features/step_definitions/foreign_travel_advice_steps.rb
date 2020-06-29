When "I publish a new travel advice edition" do
  step 'I click on the link "Afghanistan"'
  step 'I click on the button "Create new edition"'
  choose "edition_update_type_minor"
  fill_in "edition_summary", with: "Smokey test"
  step 'I click on the button "Save & Publish"'
end

Then "I should see the updated travel advice" do
  step 'I visit "/foreign-travel-advice/afghanistan"'
  step 'I should see "Smokey test"'
end

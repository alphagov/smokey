When "I start the checker" do
  visit_path "/transition"
  click_link "Start now"
end

When "I answer the nationality question" do
  choose('British', visible: false)
  click_button "Continue"
end

When "I answer the where do you live question" do
  choose('Another EU country, or Switzerland, Norway, Iceland or Liechtenstein', visible: false)
  click_button "Continue"
end

When "I skip all other questions" do
  while page.has_current_path?('/transition-check/questions', ignore_query: true)
    click_button "Continue"
  end
end

Then "I should see the results page" do
  expect(page).to have_content("How to get ready for new rules in 2021: Your results")
end

Then "I should see confirmation of my answers" do
  expect(page).to have_content("You are a British national")
  expect(page).to have_content("You live in the EU")
end

Then "I should see answers applicable to me" do
  expect(page).to have_content("Find out how to apply to be a resident in the EU country you live in")
end

When "I click Subscribe link" do
  click_link "Subscribe to email updates about changes that may affect you and get a link to your results"
end

When "I click Subscribe button" do
  click_button "Subscribe"
end

Then "I should enter the email subscription workflow" do
  path = "/email/subscriptions/new?topic_id=brexit-checklist-living-eu-nationality-uk"
  page.has_current_path?(path)
end

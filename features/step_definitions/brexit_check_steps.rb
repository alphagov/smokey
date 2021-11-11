When "I start the checker" do
  visit_path "/brexit"
  click_link "Brexit checker: start now"
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
  expect(page).to have_content("Brexit checker results: what you need to do")
end

Then "I should see confirmation of my answers" do
  expect(page).to have_content("You are a British national")
  expect(page).to have_content("You live in the EU")
end

Then "I should see answers applicable to me" do
  expect(page).to have_content("Check if you need to apply for a new residence status")
end

When "I visit the postcode checker" do
  visit_path "/find-coronavirus-local-restrictions"
end

Then "I should be redirected to the national restrictions page" do
  expect(current_path).to eql("/guidance/national-lockdown-stay-at-home")
end

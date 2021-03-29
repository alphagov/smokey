When "I visit the postcode checker" do
  visit_path "/find-coronavirus-local-restrictions"
end

Then "I should be redirected to the national restrictions page" do
  expect(current_path).to eql("/guidance/covid-19-coronavirus-restrictions-what-you-can-and-cannot-do")
end

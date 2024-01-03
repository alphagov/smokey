Then /^I should see a populated country select$/ do
  countries = Nokogiri::HTML.parse(govuk_page.body)
    .css("#current-question select option")

  # Check that we have a sensible-looking number of countries, with
  # some flex for that number to change
  expect(countries.count).to be > 200
end

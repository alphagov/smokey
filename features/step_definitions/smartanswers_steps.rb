Then /^I should see a populated country select$/ do
  countries = Nokogiri::HTML.parse(@response.body)
    .css(".question select option")

  # Check that we have a sensible-looking number of countries, with
  # some flex for that number to change
  expect(countries.count).to be > 200
end

Then /^the slug should be (valid|invalid)$/ do |valid_or_invalid|
  is_valid = valid_or_invalid == "valid"

  error_message = ".govuk-error-message"

  if is_valid
    expect(@response.body).to_not have_css(error_message)
  else
    expect(@response.body).to have_css(error_message)
  end
end

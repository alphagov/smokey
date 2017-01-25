Then /^the XML ID is formed from the correct URL$/ do
  first_entry_id = Nokogiri::XML.parse(@response.body).at_xpath('/xmlns:feed/xmlns:entry[1]/xmlns:id')
  first_entry_id.text.should start_with("#{ENV['EXPECTED_GOVUK_WEBSITE_ROOT']}/foreign-travel-advice/ireland")
end

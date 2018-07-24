Then /^the XML ID is formed from the correct URL$/ do
  # Chrome returns XML inside an HTML wrapper, so this JavaScript snippet
  # extracts the XML and rebuilds the tags
  xml_body = page.execute_script('return document.getElementsByTagName("pre")[0].innerHTML.replace(/&lt;/g, "<").replace(/&gt;/g, ">")')
  first_entry_id = Nokogiri::XML.parse(xml_body).at_xpath('/xmlns:feed/xmlns:entry[1]/xmlns:id')
  expect(first_entry_id.text).to start_with("#{ENV['GOVUK_WEBSITE_ROOT']}/foreign-travel-advice/ireland")
end

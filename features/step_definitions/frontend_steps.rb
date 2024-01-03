When /^I click on the section "(.*?)"$/ do |section_name|
  link_href = Nokogiri::HTML.parse(govuk_page.body).at_xpath("//a[text()='#{section_name}']/@href")
  expect(link_href).not_to be_nil
  step "I visit \"#{link_href.value}\""
end

Then /^I should see an input field for postcode$/ do
  expect(govuk_page.body).to have_field('postcode')
end

When /^I click on the section "(.*?)"$/ do |section_name|
  link_href = Nokogiri::HTML.parse(page.body).at_xpath("//h3[text()='#{section_name}']/../@href")
  link_href.should_not == nil
  step "I visit \"#{link_href.value}\""
end

Then /^I should see an input field for postcode$/ do
  page.body.should have_field('postcode')
end

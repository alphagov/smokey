When /^I click on the section "(.*?)"$/ do |section_name|
  link_href = Nokogiri::HTML.parse(@response.body).at_xpath("//h3[text()='#{section_name}']/../@href")
  link_href.should_not == nil
  step "I visit \"#{link_href.value}\""
end

Then /^I should see the services and information section on the homepage$/ do
  html = get_request "#{@host}/", cache_bust: @bypass_varnish
  doc = Nokogiri::HTML(html)
  assert doc.css('#services-and-information')
end

Then /^I should see an input field for entering my postcode$/ do
  @response.body.should have_field('postcode')
end

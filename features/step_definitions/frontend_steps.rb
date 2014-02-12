Then /^I should see the services and information section on the homepage$/ do
  html = get_request "#{@host}/", cache_bust: @bypass_varnish
  doc = Nokogiri::HTML(html)
  assert doc.css('#services-and-information')
end

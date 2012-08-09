Then /^I should be able to view policies$/ do
  follow_link_to_first_policy_on_policies_page
end

Then /^I should be able to view publications$/ do
  follow_link_to_first_publication_on_publications_page
end

Then /^I should be able to view government search results for "([^"]*)"$/ do |term|
  html = get_request "#{@host}/government/search?q=#{term}", cache_bust: @bypass_varnish
  doc = Nokogiri::HTML(html)
  assert doc.css('.search_results li').count > 0, "No search results returned from /government/search for '#{term}'"
end

Then /^I should be able to view specialist search results for "([^"]*)"$/ do |term|
  html = get_request "#{@host}/specialist/search?q=#{term}", cache_bust: @bypass_varnish
  doc = Nokogiri::HTML(html)
  assert doc.css('.search-results li').count > 0, "No search results returned from /specialist/search for '#{term}'"
end

def follow_link_to_first_policy_on_policies_page
  html = get_request("#{@host}/government/policies", cache_bust: @bypass_varnish)
  doc = Nokogiri::HTML(html)
  link_to_policy = doc.at('.policy a')
  assert link_to_policy.present?, "No policy links found"
  href = link_to_policy.attributes['href'].value
  get_request("#{@host}#{href}", cache_bust: @bypass_varnish)
end

def follow_link_to_first_publication_on_publications_page
  html = get_request("#{@host}/government/publications", cache_bust: @bypass_varnish)
  doc = Nokogiri::HTML(html)
  link_to_publication = doc.at('#publications-container .publication a')
  assert link_to_publication.present?, "No publication links found"
  href = link_to_publication.attributes['href'].value
  p "requesting #{@host}#{href}"
  get_request("#{@host}#{href}", cache_bust: @bypass_varnish)
end

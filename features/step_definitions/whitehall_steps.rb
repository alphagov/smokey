Then /^I should see the departments and policies section on the homepage$/ do
  html = get_request "#{@host}/", cache_bust: @bypass_varnish
  doc = Nokogiri::HTML(html)
  assert doc.css('#departments-and-policy')
end

Then /^I should be able to view policies$/ do
  follow_link_to_first_policy_on_policies_page
end

Then /^I should be able to view publications$/ do
  follow_link_to_first_publication_on_publications_page
end

Then /^I should be able to view announcements$/ do
  follow_link_to_first_announcement_on_announcements_page(2)
end

When /^I do a whitehall search for "([^"]*)"$/ do |term|
  url = "#{@host}/government/publications?keywords=#{uri_escape(term)}"
  @response = get_request(url, cache_bust: @bypass_varnish)
end

def follow_link_to_first_policy_on_policies_page
  html = get_request("#{@host}/government/policies", cache_bust: @bypass_varnish)
  doc = Nokogiri::HTML(html)
  link_to_policy = doc.at('.document a')
  assert ! link_to_policy.nil?, "No policy links found"
  href = link_to_policy.attributes['href'].value
  get_request("#{@host}#{href}", cache_bust: @bypass_varnish)
end

def follow_link_to_first_announcement_on_announcements_page(page=1)
  html = get_request("#{@host}/government/announcements?page=#{page}", cache_bust: @bypass_varnish)
  doc = Nokogiri::HTML(html)
  link_to_announcement = doc.at('.document-row a')
  assert ! link_to_announcement.nil?, "No announcement links found"
  href = link_to_announcement.attributes['href'].value
  get_request("#{@host}#{href}", cache_bust: @bypass_varnish)
end

def follow_link_to_first_publication_on_publications_page
  html = get_request("#{@host}/government/publications", cache_bust: @bypass_varnish)
  doc = Nokogiri::HTML(html)
  link_to_publication = doc.at('.document-row a')
  assert ! link_to_publication.nil?, "No publication links found"
  href = link_to_publication.attributes['href'].value
  get_request("#{@host}#{href}", cache_bust: @bypass_varnish)
end

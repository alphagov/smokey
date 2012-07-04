Then /^I should be able to view policies$/ do
  follow_link_to_first_policy_on_policies_page
end

def follow_link_to_first_policy_on_policies_page
  html = get_request("#{@host}/government/policies", cache_bust: @bypass_varnish)
  doc = Nokogiri::HTML(html)
  link_to_policy = doc.at('.policy a')
  href = link_to_policy.attributes['href'].value
  get_request("#{@host}#{href}", cache_bust: @bypass_varnish)
end
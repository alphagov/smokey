require 'json'

Then /^I should see a consistent JSON format for the path "([^"]*)"$/ do |path|
  json = get_request "#{@host}#{path}", cache_bust: @bypass_varnish
  json = JSON.parse(json)
  assert json["england-and-wales"]
  assert json["england-and-wales"]["events"]
  assert json["england-and-wales"]["events"].length
  result = json["england-and-wales"]["events"].first
  assert result["title"]
  assert result["date"]
end

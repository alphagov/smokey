Then /^I should see the departments and policies section on the homepage$/ do
  visit_path "/"
  assert page.first('#departments-and-policy')
end

Then /^I should be able to view publications$/ do
  follow_link_to_first_publication_on_publications_page
end

When /^I do a whitehall search for "([^"]*)"$/ do |term|
  visit_path "/government/publications?keywords=#{uri_escape(term)}"
end

When(/^I request an attachment$/) do
  @attachment_path = '/government/uploads/system/uploads/attachment_data/file/618167/government_dietary_recommendations.pdf'
  step %Q(I request "#{@attachment_path}")
end

Then(/^I should be redirected to the asset host$/) do
  asset_hosts = [
    application_external_url("assets-origin"),
    application_external_url("assets")
  ]
  uri = URI(@response.request.url)
  asset_url = "#{uri.scheme}://#{uri.host}"
  assert asset_hosts.include?(asset_url), "Asset host #{asset_url} is not valid"
end

Then(/^the attachment should be served successfully$/) do
  expect(@response.request.url).to match(@attachment_path)
  expect(@response.code).to eq(200)
end

def follow_link_to_first_publication_on_publications_page
  visit_path "/government/publications"
  visit_path page.first('.document a')['href']
end

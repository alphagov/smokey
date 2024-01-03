When(/^I request an attachment$/) do
  @attachment_path = '/government/uploads/system/uploads/attachment_data/file/618167/government_dietary_recommendations.pdf'
  step %Q(I request "#{@attachment_path}")
end

Then(/^I should be redirected to the asset host$/) do
  asset_hosts = [
    application_external_url("assets-origin"),
    application_external_url("assets-eks"),
    application_external_url("assets"),
  ]
  uri = URI(@response.request.url)
  asset_url = "#{uri.scheme}://#{uri.host}"
  assert asset_hosts.include?(asset_url), "Asset host #{asset_url} is not valid"
end

Then(/^the attachment should be served successfully$/) do
  expect(@response.request.url).to match(@attachment_path)
  expect(govuk_page.status_code).to eq(200)
end

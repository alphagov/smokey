Given /^there is an S3 mirror (.+)/ do |mirror|
  @mirror_host = mirror
end

Then /^I should get a (\d+) response from "(.*)" on the mirror$/ do |status, path|
  get_request("#{@mirror_host}#{path}", default_request_options.merge(dont_follow_redirects: true))
  expect(govuk_page.status_code).to eq(status.to_i)
end

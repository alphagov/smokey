Given /^there is an S3 mirror (.+)/ do |mirror|
  @mirror_host = mirror
end

Then /^I should get a (\d+) response from "(.*)" on the mirror$/ do |status, path|
  response = single_http_request(
    "#{@mirror_host}#{path}"
  )
  expect(response.code.to_i).to eq(status.to_i)
end

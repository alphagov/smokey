Given /^S3 mirrors/ do
  @hosts = Array.new()
  @hosts.push("https://govuk-production-mirror.s3.amazonaws.com")
  @hosts.push("https://govuk-production-mirror-replica.s3.amazonaws.com")
end

Then /^I should get a (\d+) response from "(.*)" on the mirrors$/ do |status, path|
  @responses = []
  @hosts.each do |mirror_host|
    response = single_http_request(
      "#{mirror_host}#{path}"
    )
    expect(response.code.to_i).to eq(status.to_i)
    @responses << response
  end
end

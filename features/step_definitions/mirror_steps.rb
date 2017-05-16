Given /^mirror provider (\d)/ do |provider|
  @hosts = Array.new()
  @hosts.push("https://www-origin.mirror.provider#{provider}.production.govuk.service.gov.uk")
end

Given /^there are (\d) mirrors in provider (\d)/ do |mirrors, provider|
  @hosts = Array.new()
  mirror_max = mirrors.to_i - 1
  for m in 0..mirror_max do
    @hosts.push("https://mirror#{m}.mirror.provider#{provider}.production.govuk.service.gov.uk")
  end
end

Then /^I should get a (\d+) response from "(.*)" on the mirrors$/ do |status, path|
  @responses = []
  @hosts.each do |mirror_host|
    response = try_get_request(
      "#{mirror_host}#{path}",
      host_header: "www-origin.mirror.production.govuk.service.gov.uk",
      verify_ssl: false,
    )
    response.code.should == status.to_i
    @responses << response
  end
end

Then /^I should see a technical difficulties message$/ do
  @responses.each do |response|
    expect(response.body).to include("Sorry, we're experiencing technical difficulties")
  end
end

Given /^there are (\d) mirror providers/ do |providers|
  @hosts = Array.new()
  provider_max = providers.to_i - 1
  for p in 0..provider_max do
    @hosts.push("https://www-origin.mirror.provider#{p}.production.govuk.service.gov.uk")
  end
end

Given /^there are (\d) mirrors and (\d) providers/ do |mirrors,providers|
  @hosts = Array.new()
  mirror_max = mirrors.to_i - 1
  provider_max = providers.to_i - 1
  for p in 0..provider_max do
    for m in 0..mirror_max do
      @hosts.push("https://mirror#{m}.mirror.provider#{p}.production.govuk.service.gov.uk")
    end
  end
end

Then /^I should get a (\d+) response from "(.*)" on the mirrors$/ do |status, path|
  @responses = []
  @hosts.each do |mirror_host|
    response = try_get_request("#{mirror_host}#{path}", host_header: "www-origin.mirror.production.govuk.service.gov.uk")
    response.code.should == status.to_i
    @responses << response
  end
end

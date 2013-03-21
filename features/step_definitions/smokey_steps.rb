Given /^the "(.*)" application has booted$/ do |app_name|
  url = application_base_url(app_name)
  head_request(url)
end

Given /^I am testing "(.*)"/ do |host|
  if host.include? "://"
    @host = host
  else
    @host = application_base_url(host)
  end
end

Given /^I am testing through the full stack$/ do
  @host = base_url
  @bypass_varnish = false
  @authenticated = true
end

Given /^I force a varnish cache miss$/ do
  @bypass_varnish = true
end

Given /^I am not an authenticated user$/ do
  @authenticated = false
end

Given /^I am an authenticated API client$/ do
  @authenticated_as_client = true
end

When /^I go to the "([^"]*)" landing page$/ do |app_name|
  url = application_base_url(app_name)
  parsed_url = URI.parse(url)
  base_host = "#{parsed_url.scheme}://#{parsed_url.host}"

  page.driver.browser.agent.add_auth(base_host, ENV['AUTH_USERNAME'], ENV['AUTH_PASSWORD'])

  visit url
end

When /^I (try to )?visit "(.*)"$/ do |attempt_only, path_or_url|
  url = if path_or_url.start_with?("http")
    path_or_url
  else
    "#{@host}#{path_or_url}"
  end
  request_method = attempt_only ? :try_get_request : :get_request
  @response = send(request_method, url, default_request_options)
end

When /^I visit "(.*)" without following redirects$/ do |path|
  @response = single_http_request("#{@host}#{path}")
end

When /^I visit "([^"]*)" on the "([^"]*)" application$/ do |path, application|
  application_host = application_base_url(application)
  @response = get_request("#{application_host}#{path}", default_request_options)
end

When /^I visit "(.*)" (\d+) times$/ do |path, count|
  count.to_i.times {
    @response = get_request("#{@host}#{path}", default_request_options)
  }
end

When /^I search for "(.*)"$/ do |term|
  @response = get_request("#{@host}/search?q=#{term}", default_request_options)
end

Then /^I should be able to visit:$/ do |table|
  table.hashes.each do |row|
    response = get_request("#{@host}#{row['Path']}", default_request_options)
    response.code.should == 200
  end
end

Then /^I should receive "(\d+)" result/ do |count|
  @response.body.include?("#{count} result found").should == true
end

Then /^I should receive no results/ do
  @response.body.include?("find any results for").should == true
end

Then /^I should get a (\d+) status code$/ do |status|
  @response.code.to_i.should == status.to_i
end

Then /^I should get a location of "(.*)"$/ do |location|
  @response['location'].should == location
end

Then /I should get a content length of "(\d+)"/ do |length|
  @response.net_http_res['content-length'].should == length
end

Then /^I should see "(.*)"$/ do |content|
  if @response
    @response.body.include?(content).should == true
  elsif page
    page.body.include?(content).should == true
  end
end

When /^I click "(.*?)"$/ do |link_text|
  link_href = Nokogiri::HTML.parse(@response.body).at_xpath("//a[text()='#{link_text}']/@href")
  link_href.should_not == nil
  step "I visit \"#{link_href.value}\""
end

When /^I try to post to "(.*)" with "(.*)"$/ do |path, payload|
  @response = post_request "#{@host}#{path}", :payload => "#{payload}"
end

When /^I do a search for consultancy in the See Live Opportunities Section$/ do
  @response = get_request("#{@host}/Search%20Contracts/Search%20Contracts%20Results.aspx?site=1002&lang=en&sc=095268e8-030d-4ad6-a7d9-81827a64f32c")
end

When /^I do a search for computer in the what's being bought by government$/ do
  @response = get_request("#{@host}/Search%20Contracts/Search%20Contracts%20Results.aspx?site=1002&lang=en&sc=fdd1df44-c8e8-4f2b-b990-e3a0fdd28ae2")
end

Then /^I should see some results$/ do
  @response.body.include?("No results found").should == false
end

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

When /^I search for "(.*)" using tabbed search$/ do |term|
  @response = get_request("#{@host}/search?q=#{term}&ui=old", default_request_options)
end

When /^I search for "(.*)" using unified search$/ do |term|
  @response = get_request("#{@host}/search?q=#{term}&ui=unified", default_request_options)
end

When /^I request "(.*)" from Bouncer directly$/ do |url|
  parsed_url = URI.parse(url)
  bouncer_url = "#{@host}#{parsed_url.path}"
  bouncer_url += "?#{parsed_url.query}" if parsed_url.query
  request_host = parsed_url.host

  @response = try_get_request(bouncer_url, host_header: request_host)
end

def should_visit(path)
  @response = get_request("#{@host}#{path}", default_request_options)
  @response.code.should == 200
end

def should_see(text)
  @response.body.include?(text).should == true
end

Then /^I should be able to visit:$/ do |table|
  table.hashes.each do |row|
    should_visit(row['Path'])
  end
end

Then /^I should be able to visit and see:$/ do |table|
  table.hashes.each do |row|
    should_visit(row['Path'])
    should_see(row['See'])
  end
end

Then /^I should get a (\d+) response when I try to visit:$/ do |status, table|
  table.hashes.each do |row|
    response = try_get_request("#{@host}#{row['Path']}", default_request_options)
    response.code.should == status.to_i
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

Then /^I should get a location header of "(.*)"$/ do |location|
  @response.headers[:location].should == location
end

Then /^I should get a cache control header of "(.*)"$/ do |cache_control|
  @response.headers[:cache_control].should == cache_control
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

Then /^I should see some search results$/ do
  result_links = Nokogiri::HTML.parse(@response.body).css(".results-list li a")
  result_links.count.should >= 1
end

Then /^I should see organisations in the organisation filter$/ do
  organisation_options = Nokogiri::HTML.parse(@response.body).css("select[name=organisation] option")
  organisation_options.count.should >= 10
end

Then /^I should see organisations in the unified organisation filter$/ do
  organisation_options = Nokogiri::HTML.parse(@response.body).css("#organisations-filter input")
  organisation_options.count.should >= 10
end

Then /^I should see Publisher's publication index$/ do
  page.should have_content("publications")
  page.should have_selector("#publication-list-container")
end

require "json"

Given /^I am testing "(.*)"$/ do |host|
  if host.include? "://"
    @host = host
  else
    @host = application_external_url(host)
  end

  Capybara.app_host = @host
end

Given /^I am testing "(.*)" internally/ do |host|
  if host.include? "://"
    @host = host
  else
    @host = application_internal_url(host)
  end

  Capybara.app_host = @host
  @bypass_caching = false
end

Given /^I am an authenticated API client$/ do
  @authenticated_as_client = true
end

Given /^I try not to bypass caching$/ do
  @bypass_caching = false
end

And /^I consent to cookies$/ do
  visit_path "/"
  click_button "Accept"

  consent_cookie = Capybara
    .current_session
    .driver
    .browser
    .manage
    .cookie_named("cookies_policy")

  @consent_cookie_value = consent_cookie[:value]
end

When /^I go to the "imminence" landing page$/ do
  visit_path application_external_url("places-manager")
end

When /^I go to the "([^"]*)" landing page$/ do |app_name|
  visit_path application_external_url(app_name)
end

When /^I request "(.*)"$/ do |path_or_url|
  url = if path_or_url.start_with?("http")
    path_or_url
  else
    "#{@host}#{path_or_url}"
  end
  @response = send(:get_request, url, default_request_options)
end

When /^I visit "(.*)"$/ do |path_or_url|
  visit_path path_or_url
end

When /^I visit "(.*)" without following redirects$/ do |path|
  @response = single_http_request("#{@host}#{path}")
end

When /^I visit "([^"]*)" on the "([^"]*)" application$/ do |path, application|
  application_host = application_external_url(application)
  visit_path "#{application_host}#{path}"
end

When /^I visit a non-existent page$/ do
  @response = get_request("#{@host}/404", default_request_options.merge(return_response_on_error: true))
end

When /^I request "(.*)" from Bouncer directly$/ do |url|
  parsed_url = URI.parse(url)
  bouncer_url = "#{@host}#{parsed_url.path}"
  bouncer_url += "?#{parsed_url.query}" if parsed_url.query
  request_host = parsed_url.host

  @response = try_get_request(bouncer_url, host_header: request_host)
end

$original_env_var = ENV["RATE_LIMIT_TOKEN"] # retain original value so we can reset it after the tests
Given /^the 'RATE_LIMIT_TOKEN' ENV variable is set$/ do
  ENV["RATE_LIMIT_TOKEN"] = "foo"
end

Given /^the 'RATE_LIMIT_TOKEN' ENV variable is NOT set$/ do
  ENV.delete("RATE_LIMIT_TOKEN")
end

Then /^any request I make should include the 'Rate-Limit-Token' header$/ do
  request = create_request("https://www.gov.uk")
  ENV["RATE_LIMIT_TOKEN"] = $original_env_var
  expect(request.headers["Rate-Limit-Token"]).to eq("foo")
end

Then /^any request I make should NOT include the 'Rate-Limit-Token' header$/ do
  request = create_request("https://www.gov.uk")
  ENV["RATE_LIMIT_TOKEN"] = $original_env_var
  expect(request.headers["Rate-Limit-Token"]).to be_nil
end

def should_visit(path)
  @response = get_request("#{@host}#{path}", default_request_options)
  expect(@response.code).to eq(200)
end

def should_see(text)
  expect(@response.body).to have_content(text)
end

And /^I don't care about JavaScript errors/ do
  $fail_on_js_error = false
end

Then /^I should be able to visit:$/ do |table|
  table.hashes.each do |row|
    visit_path row['Path']
  end
end

Then /^I should get a (\d+) status code$/ do |expected_status|
  if @response
    actual_status = @response.code.to_i
    url = @response['location']
  else
    actual_status = page.status_code.to_i
    url = page.current_url
  end

  expect(expected_status.to_i).to(
    eq(actual_status),
    "#{url}: expected status #{expected_status.to_i} got #{actual_status}"
  )
end

Then /^I should get a "(.*)" header of "(.*)"$/ do |header_name, header_value|
  header_as_symbol = header_name.gsub('-', '_').downcase.to_sym

  if @response.respond_to? :headers
    expect(@response.headers[header_as_symbol]).to eq(header_value)
  elsif @response[header_name]
    expect(@response[header_name]).to eq(header_value)
  else
    raise "Couldn't find header '#{header_name}' in response"
  end
end

Then /^I should see "(.*)"$/ do |content|
  if @response
    expect(@response.body).to include(content)
  elsif page
    wait_for_any_redirects_to_govuk
    expect(page.body).to include(content)
  end
end

Then /^I should be at a location path of "(.*)"$/ do |location_path|
  if @response
    uri = URI(@response['location'])
    expect(uri.path).to eq(location_path)
  else
    wait_for_any_redirects_to_govuk
    uri = URI(page.current_url)
    expect(uri.path).to eq(location_path)
  end
end

When /^I try to post to "(.*)" with "(.*)"$/ do |path, payload|
  @response = post_request "#{@host}#{path}", :payload => "#{payload}"
end

When /^I try to post to "(.*)" with "(.*)" without following redirects$/ do |path, payload|
  @response = post_request "#{@host}#{path}", :payload => "#{payload}", dont_follow_redirects: true
end

Then /^JSON is returned$/ do
  expect(JSON.parse(@response.body).class).to eq(Hash)
end

When /^I see the links pulled form search_api$/ do
  latest_section = Nokogiri::HTML.parse(page.body).css("#latest")
  latest_items_list = latest_section.css(".gem-c-document-list ul")
  latest_items = latest_items_list.css(".gem-c-document-list__item-metadata")

  unless latest_items.any?
    fail `There are no "latest" links pulled in from the search api`
  end
end

Then /^I should hit the cache$/ do
  cache_hits = cache_hits_value(@response)

  expect(cache_hits).not_to be nil
  expect(cache_hits).not_to be("0")
end

Then /^I should not hit the cache$/ do
  cache_hits = cache_hits_value(@response)

  expect(cache_hits).not_to be nil
  expect(cache_hits).to eq("0")
end

def cache_hits_value(response)
  header_name = 'X-Cache-Hits'
  header_as_symbol = header_name.gsub('-', '_').downcase.to_sym

  if response.respond_to? :headers
    response.headers[header_as_symbol]
  elsif response['X-Cache-Hits'].present?
    response[header_name].to_i
  else
    raise "Couldn't find X-Cache-Hits header in response"
  end
end

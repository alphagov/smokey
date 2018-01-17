require 'json'

Given /^I am testing "(.*)"/ do |host|
  if host.include? "://"
    @host = host
  else
    @host = application_external_url(host)
  end
end

Given /^I am testing "(.*)" internally/ do |host|
  if host.include? "://"
    @host = host
  else
    @host = application_internal_url(host)
  end
end

Given /^I am testing through the full stack$/ do
  @host = ENV["GOVUK_WEBSITE_ROOT"]
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
  visit_path application_external_url(app_name)
end

When /^I (try to )?request "(.*)"$/ do |attempt_only, path_or_url|
  url = if path_or_url.start_with?("http")
    path_or_url
  else
    "#{@host}#{path_or_url}"
  end
  request_method = attempt_only ? :try_get_request : :get_request
  @response = send(request_method, url, default_request_options)
end

When /^I visit "(.*)"$/ do |path_or_url|
  visit_path path_or_url
end

When /^I try to visit "(.*)"$/ do |path_or_url|
  visit_path path_or_url
end

When /^I visit "(.*)" without following redirects$/ do |path|
  @response = single_http_request("#{@host}#{path}")
end

When /^I visit "([^"]*)" on the "([^"]*)" application$/ do |path, application|
  application_host = application_internal_url(application)
  @response = get_request("#{application_host}#{path}", default_request_options)
end

When /^I visit "(.*)" (\d+) times$/ do |path, count|
  count.to_i.times {
    @response = get_request("#{@host}#{path}", default_request_options)
  }
end

When(/^multiple new users visit "(.*?)"$/) do |path|
  @responses = []
  20.times do
    @responses << get_request("#{@host}#{path}", default_request_options)
  end
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

def should_visit(path)
  @response = get_request("#{@host}#{path}", default_request_options)
  @response.code.should == 200
end

def should_see(text)
  expect(@response.body).to have_content(text)
end

Then /^I should be able to visit:$/ do |table|
  table.hashes.each do |row|
    visit_path row['Path']
  end
end

Then /^I should be redirected when I try to visit:$/ do |table|
  table.hashes.each do |row|
    visit_path row['Path']
    page.current_path.should_not == row['Path']
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
    @response.headers[header_as_symbol].should == header_value
  elsif @response[header_name]
    @response[header_name].should == header_value
  else
    raise "Couldn't find header '#{header_name}' in response"
  end
end

Then /I should get a content length of "(\d+)"/ do |length|
  @response.net_http_res['content-length'].should == length
end

Then /^I should see "(.*)"$/ do |content|
  if @responses
    @responses.each do |response|
      expect(response.body).to include(content)
    end
  elsif @response
    expect(@response.body).to include(content)
  elsif page
    expect(page.body).to include(content)
  end
end

Then /^I should be at a location path of "(.*)"$/ do |location_path|
  url = "#{@host}#{location_path}"
  if @response
    @response['location'].should == url
  else
    page.current_url.should == url
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

Then /^the logo should link to the homepage$/ do
  logo = Nokogiri::HTML.parse(page.body).at_css('#logo')
  logo.attributes['href'].value.should == ENV['EXPECTED_GOVUK_WEBSITE_ROOT']
end

Then /^I should see Publisher's publication index$/ do
  page.should have_selector("#publication-list-container")
end

Then /^I should be able to navigate the topic hierarchy$/ do
  topics = Nokogiri::HTML.parse(page.body).css("nav.topics li a")
  random_path_selection(anchor_tags: topics).each do |path|
    visit_path path

    subtopics = Nokogiri::HTML.parse(page.body).css("nav.topics li a")
    random_path_selection(anchor_tags: subtopics).each do |path|
      visit_path path
    end
  end
end

Then /^I should be able to navigate the browse pages$/ do
  categories = Nokogiri::HTML.parse(page.body).css(".browse-panes ul li a")
  random_path_selection(anchor_tags: categories).each do |path|
    visit_path path

    subcategories = Nokogiri::HTML.parse(page.body).css(".pane-inner ul li a")
    random_path_selection(anchor_tags: subcategories).each do |path|
      visit_path path
    end
  end
end

Then /^JSON is returned$/ do
  JSON.parse(@response.body).class.should == Hash
end

def random_path_selection(opts={})
  size = opts[:size] || 3
  anchor_tags = opts[:anchor_tags] || []
  anchor_tags.map { |anchor| anchor.attributes["href"].value }.sample(size)
end

When /^I inject a JavaScript error on the page, Smokey( does not)? raises? an exception$/ do |no_exception|
  should_raise_exception = no_exception.nil?
  if should_raise_exception
    expect { page.driver.execute_script('1.error') }.to raise_error
  end
end

When /^I see links to pages per topic$/ do
  pages = Nokogiri::HTML.parse(page.body).css(".browse-container a")
  unless pages.any?
    fail "There are no links on this Services and Information page"
  end
end

Before('@ignore_javascript_errors') do
  page.driver.browser.js_errors = false
end

After('@ignore_javascript_errors') do
  page.driver.browser.js_errors = true
end

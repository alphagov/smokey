Given /^I am testing "(.*)"/ do |host|
  if host.include? "://"
    @host = host
  else
    @host = application_base_url(host)
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

When /^I visit a non-existent page$/ do
  @response = get_request("#{@host}/404", default_request_options.merge(return_response_on_error: true))
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
  expect(@response.code).to eq(200)
end

def should_see(text)
  expect(@response.body.include?(text)).to be_true
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
    expect(response.code).to eq(status.to_i)
  end
end

Then /^I should get a (\d+) status code$/ do |status|
  expect(@response.code.to_i).to eq status.to_i
end

Then /^I should get a Content-Type header of "(.*)"$/ do |content_type|
  expect(@response.headers[:content_type]).to eq(content_type)
end

Then /^I should get a location of "(.*)"$/ do |location|
  expect(@response['location']).to eq(location)
end

Then /^I should get a location header of "(.*)"$/ do |location|
  expect(@response.headers[:location]).to eq(location)
end

Then /^I should get a cache control header of "(.*)"$/ do |cache_control|
  expect(@response.headers[:cache_control]).to eq(cache_control)
end

Then /I should get a content length of "(\d+)"/ do |length|
  expect(@response.net_http_res['content-length']).to eq(length)
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

When /^I click "(.*?)"$/ do |link_text|
  link_href = Nokogiri::HTML.parse(@response.body).at_xpath("//a[text()='#{link_text}']/@href")
  link_href.should_not == nil
  step "I visit \"#{link_href.value}\""
end

When /^I try to post to "(.*)" with "(.*)"$/ do |path, payload|
  @response = post_request "#{@host}#{path}", :payload => "#{payload}"
end

Then /^the logo should link to the homepage$/ do
  logo = Nokogiri::HTML.parse(@response.body).at_css('#logo')
  expect(logo.attributes['href'].value).to eq ENV['EXPECTED_GOVUK_WEBSITE_ROOT']
end

Then /^I should see some search results$/ do
  result_links = Nokogiri::HTML.parse(@response.body).css(".results-list li a")
  expect(result_links.count).to be >= 1
end

Then /^I should see organisations in the unified organisation filter$/ do
  organisation_options = Nokogiri::HTML.parse(@response.body).css("#organisations-filter input")
  expect(organisation_options.count).to be >= 10
end

Then /^I should see Publisher's publication index$/ do
  expect(page).to have_selector("#publication-list-container")
end

Then /^I should be able to navigate the topic hierarchy$/ do
  topics = Nokogiri::HTML.parse(@response.body).css("nav.topics li a")
  random_path_selection(anchor_tags: topics).each do |path|
    should_visit(path)
    subtopics = Nokogiri::HTML.parse(@response.body).css("nav.topics li a")
    random_path_selection(anchor_tags: subtopics).each do |path|
      should_visit(path)
    end
  end
end

Then /^I should be able to navigate the browse pages$/ do
  categories = Nokogiri::HTML.parse(@response.body).css(".browse-panes ul li a")
  random_path_selection(anchor_tags: categories).each do |path|
    should_visit(path)
    subcategories = Nokogiri::HTML.parse(@response.body).css(".pane-inner ul li a")
    random_path_selection(anchor_tags: subcategories).each do |path|
      should_visit(path)
    end
  end
end

def random_path_selection(opts={})
  size = opts[:size] || 3
  anchor_tags = opts[:anchor_tags] || []
  anchor_tags.map { |anchor| anchor.attributes["href"].value }.sample(size)
end

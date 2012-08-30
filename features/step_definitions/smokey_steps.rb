require 'plek'
require 'mysql2'
require 'stomp'
require 'mongo'

Given /^the "(.*)" application has booted$/ do |app_name|
  platform = target_platform
  url = case app_name
  when 'calendars' then "http://calendars.#{platform}.alphagov.co.uk/bank-holidays"
  when 'frontend' then "https://frontend.#{platform}.alphagov.co.uk/"
  when 'licencefinder' then "https://licencefinder.#{platform}.alphagov.co.uk/licence-finder"
  when 'planner' then "https://planner.#{platform}.alphagov.co.uk/maternity"
  when 'search' then "https://search.#{platform}.alphagov.co.uk/search"
  when 'smartanswers' then "http://smartanswers.#{platform}.alphagov.co.uk/maternity-benefits"
  when 'tariff-backend' then "https://tariff-api.#{platform}.alphagov.co.uk/"
  when 'tariff-frontend' then "https://tariff.#{platform}.alphagov.co.uk/trade-tariff"
  when 'whitehall' then "http://whitehall-frontend.#{platform}.alphagov.co.uk/government"
  else
    raise "Application '#{app_name}' not recognised, unable to boot it up"
  end
  head_request(url)
end

Given /^I am testing through the full stack$/ do
  @host = base_url
  @bypass_varnish = false
end

Given /^I force a varnish cache miss$/ do
  @bypass_varnish = true
end

When /^I visit "(.*)"$/ do |path|
  @response = get_request("#{@host}#{path}", cache_bust: @bypass_varnish)
end

When /^I visit "(.*)" (\d+) times$/ do |path, count|
  count.to_i.times {
    @response = get_request("#{@host}#{path}", cache_bust: @bypass_varnish)
  }
end

When /^I search for "(.*)"$/ do |term|
  @response = get_request("#{@host}/search?q=#{term}", cache_bust: @bypass_varnish)
end

Then /^I should be able to visit:$/ do |table|
  table.hashes.each do |row|
    response = get_request("#{@host}#{row['Path']}", cache_bust: @bypass_varnish)
    response.code.should == 200
  end
end

Then /^I should not be able to access critical ports$/ do
  ports_to_check = [17, 20, 21, 23, 25, 3306, 3724, 27017] # 8080 is open for puppetDB console; we should close this again at some point
  ports_to_check.each do |port|
    connect_to_port(URI.parse(@host).host, port).should be_false, "Port #{port} appears to be open.  This shouldn't be the case."
  end
end

Then /^I should be able to access port (.*)$/ do |port|
  connect_to_port(URI.parse(@host).host, port).should be_true
end

Then /^I should receive "(\d+)" result/ do |count|
  @response.body.include?("#{count} result found").should == true
end

Then /^I should receive no results/ do
  @response.body.include?("find any results for").should == true
end

Then /^I should get a (\d+) status code$/ do |status|
  @response.code.should == status.to_i
end

Then /^I should get content from the cache$/ do
  @response.headers[:x_cache].should == "HIT"
end


require 'plek'
require 'rest_client'

Given /^I am testing "(.*)"$/ do |service|
  p = Plek.new ENV['TARGET_PLATFORM'] || "preview"

  @password = ENV['AUTH_PASSWORD']
  @username = ENV['AUTH_USERNAME']

  @host = p.find(service).gsub("http", "https")
  puts @host
end

When /^I visit "(.*)"$/ do |path|
  url = "#{@host}#{path}"
  @response = RestClient::Request.new(:url => url, :method => 'get', :user => @username, :password => @password).execute
end

When /^I visit "(.*)" twice$/ do |path|
  url = "#{@host}#{path}"
  RestClient::Request.new(:url => url, :method => 'get', :user => @username, :password => @password).execute
  @response = RestClient::Request.new(:url => url, :method => 'get', :user => @username, :password => @password).execute
end

When /^I search for "(.*)"$/ do |term|
  url = "#{@host}/search?q=#{term}"
  RestClient::Request.new(:url => url, :method => 'get', :user => @username, :password => @password).execute
  @response = RestClient::Request.new(:url => url, :method => 'get', :user => @username, :password => @password).execute
end

Then /^I should be able to visit:$/ do |table|
  table.hashes.each do |row|
    url = "#{@host}#{row['Path']}"
    response = RestClient::Request.new(:url => url, :method => 'get', :user => @username, :password => @password).execute
    response.code.should == 200
  end
end

Then /^I should see "(.*)"$/ do |text|
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

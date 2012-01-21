require 'plek'
require 'mysql2'
require 'rest_client'
require 'stomp'

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

When /^I visit "(.*)" (\d+) times$/ do |path, count|
  url = "#{@host}#{path}"
  (count.to_i-1).times {
    RestClient::Request.new(:url => url, :method => 'get', :user => @username, :password => @password).execute
  }
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

Given /^I connect to "(.*)" on "(.*)"$/ do |database,host|
  @client = Mysql2::Client.new(:host => host, :username => ENV['MYSQL_USERNAME'], :password => ENV['MYSQL_PASSWORD'], :database => database)
end

Then /^I should be able to make a successful query with "(.*)"$/ do |query|
  @client.query(query)
end

Given /^I connect to the queue on "(.*)"$/ do |host|
  @host = host
  @conn = Stomp::Connection.new("", "", host, 61613)
end

When /^I send a ping to "(.*)"$/ do |queue|
  @queue = queue
  @conn.publish(queue, "ping")
  @conn.disconnect
end

Then /^I should be able to receive the message$/ do
  consumer = Stomp::Connection.new("", "", @host, 61613)
  consumer.subscribe(@queue)
  consumer.receive.body.chomp.should == "ping"
  consumer.disconnect
end

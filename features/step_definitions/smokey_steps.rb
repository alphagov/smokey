require 'plek'
require 'mysql2'
require 'rest_client'
require 'stomp'
require 'mongo'
require 'net/http'

Given /^I am testing "(.*)"$/ do |service|
  p = Plek.new ENV['TARGET_PLATFORM'] || "preview"

  @password = ENV['AUTH_PASSWORD']
  @username = ENV['AUTH_USERNAME']

  @host = p.find(service)
  @host = @host.gsub("http", "https") unless @host.include? "whitehall"
  puts @host
end

When /^I visit "(.*)"$/ do |path|
  url = "#{@host}#{path}"
  @response = RestClient::Request.new(:url => url, :method => :get, :user => @username, :password => @password).execute
end

When /^I visit "(.*)" (\d+) times$/ do |path, count|
  url = "#{@host}#{path}"
  (count.to_i-1).times {
    RestClient::Request.new(:url => url, :method => :get, :user => @username, :password => @password).execute
  }
  @response = RestClient::Request.new(:url => url, :method => :get, :user => @username, :password => @password).execute
end

When /^I search for "(.*)"$/ do |term|
  url = "#{@host}/search?q=#{term}"
  RestClient::Request.new(:url => url, :method => :get, :user => @username, :password => @password).execute
  @response = RestClient::Request.new(:url => url, :method => :get, :user => @username, :password => @password).execute
end

Then /^I should be able to visit:$/ do |table|
  table.hashes.each do |row|
    url = "#{@host}#{row['Path']}"
    response = RestClient::Request.new(:url => url, :method => :get, :user => @username, :password => @password).execute
    response.code.should == 200
  end
end

Then /^I should not be able to access critical ports$/ do
  ports_to_check = [17, 20, 21, 23, 25, 3306, 3724, 8080, 27017]
  ports_to_check.each do |port|
    puts "Attempting port #{port}.."
    connect_to_port(URI.parse(@host).host, port).should be_false
  end
end

Then /^I should be able to access port (.*)$/ do |port|
  connect_to_port(URI.parse(@host).host, port).should be_true
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

Given /^I connect to the mongo instance on "(.*)"$/ do |host|
  @mongo = Mongo::Connection.new(host)
end

Then /^I should find the "(.*)" database$/ do |database|
  @mongo.database_names.include?(database).should == true
end

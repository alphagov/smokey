require 'plek'
require 'mysql2'
require 'stomp'
require 'mongo'

Given /^the "(.*)" application has booted$/ do |app_name|
  platform = ENV['TARGET_PLATFORM'] || "preview"
  url = case app_name
  when 'whitehall' then "http://whitehall-frontend.#{platform}.alphagov.co.uk/government"
  when 'calendars' then "http://calendars.#{platform}.alphagov.co.uk/bank-holidays"
  when 'smartanswers' then "http://smartanswers.#{platform}.alphagov.co.uk/maternity-benefits"
  when 'search' then "https://search.#{platform}.alphagov.co.uk/search"
  when 'frontend' then "https://frontend.#{platform}.alphagov.co.uk/"
  else
    raise "Application '#{app_name}' not recognised, unable to boot it up"
  end
  puts url
  head_request(url)
end

Given /^I am testing through the full stack$/ do
  platform = ENV['TARGET_PLATFORM'] || "preview"
  @host = platform == 'production' ? 'https://www.gov.uk' : "https://www.#{platform}.alphagov.co.uk"
  @bypass_varnish = false
  puts @host
end

Given /^I bypass the varnish cache$/ do
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
  ports_to_check = [17, 20, 21, 23, 25, 3306, 3724, 8080, 27017]
  ports_to_check.each do |port|
    puts "Attempting port #{port}.."
    connect_to_port(URI.parse(@host).host, port).should be_false
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

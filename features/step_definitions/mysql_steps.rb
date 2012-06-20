Given /^I connect to "(.*)" on "(.*)"$/ do |database,host|
  @mysql_client = Mysql2::Client.new(:host => host, :username => ENV['MYSQL_USERNAME'], :password => ENV['MYSQL_PASSWORD'], :database => database)
end

Then /^I should be able to make a successful query with "(.*)"$/ do |query|
  @mysql_client.query(query)
end
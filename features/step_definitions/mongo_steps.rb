Given /^I connect to the mongo instance on "(.*)"$/ do |host|
  @mongo_client = Mongo::Connection.new(host)
end

Then /^I should find the "(.*)" database$/ do |database|
  @mongo_client.database_names.include?(database).should == true
end

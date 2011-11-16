require 'plek'

Given /^I am testing "(.*)"$/ do |service|
  p = Plek.new ENV['ENV'] || "production"
  @host = p.find(service)
  puts @host
end

When /^I visit "(.*)"$/ do |path|
  visit @host + path
end

Then /^I should be able to visit:$/ do |table|
  table.hashes.each do |row|
    visit @host + row["Path"]
    webrat_session.response_code.should == 200
  end
end

Then /^I should see "(.*)"$/ do |text|
  response_body.should contain text
end

Then /^I should get a (\d+) status code$/ do |status|
  webrat_session.response_code.should == status.to_i
end

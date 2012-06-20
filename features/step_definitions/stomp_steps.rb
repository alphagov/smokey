Given /^I connect to the queue on "(.*)"$/ do |host|
  @stomp_host = host
  @conn = Stomp::Connection.new("", "", host, 61613)
end

When /^I send a ping to "(.*)"$/ do |queue|
  @queue = queue
  @conn.publish(queue, "ping")
  @conn.disconnect
end

Then /^I should be able to receive the message$/ do
  consumer = Stomp::Connection.new("", "", @stomp_host, 61613)
  consumer.subscribe(@queue)
  consumer.receive.body.chomp.should == "ping"
  consumer.disconnect
end

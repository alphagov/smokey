Then /^search analytics for "(.*)" are reported$/ do |term|
  sought = "dp=#{CGI::escape("/search/all?keywords=#{term.sub(' ', '+')}")}"
  wait_until { browser_has_analytics_request_containing sought }
  expect(browser_has_analytics_request_containing sought).to be(true)
end

Then /^the "(.*)" event is reported$/ do |event|
  sought = "ec=#{event}"
  wait_until { browser_has_analytics_request_containing sought }
  expect(browser_has_analytics_request_containing sought).to be(true)
end

Then /^the "(.*)" event for result (.*) is reported$/ do |event, n|
  sought = "ec=#{event}&ea=#{n}"
  wait_until { browser_has_analytics_request_containing sought }
  expect(browser_has_analytics_request_containing sought).to be(true)
end

Then /^the page view should be tracked$/ do
  sought = "t=pageview"
  wait_until { browser_has_analytics_request_containing sought }
  expect(browser_has_analytics_request_containing sought).to be(true)
end

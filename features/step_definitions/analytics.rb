Then /^the page view should be tracked$/ do
  sought = "t=pageview"
  expect(browser_has_analytics_request_containing sought).to be(true)
end

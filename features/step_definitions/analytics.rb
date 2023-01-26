Then /^search analytics for "(.*)" are reported$/ do |term|
  page.execute_script("if(window.jasmine){console.error('error: jasmine exists so analytics did not load')} else if (!window.GOVUK.analytics) { console.error('universal analytics has not loaded in yet')}")
  sought = "dp=#{CGI::escape("/search/all?keywords=#{term.sub(' ', '+')}")}"
  expect(browser_has_analytics_request_containing sought).to be(true)
end

Then /^the "(.*)" event is reported$/ do |event|
  page.execute_script("if(window.jasmine){console.error('error: jasmine exists so analytics did not load')} else if (!window.GOVUK.analytics) { console.error('universal analytics has not loaded in yet')}")
  sought = "ec=#{event}"
  expect(browser_has_analytics_request_containing sought).to be(true)
end

Then /^the "(.*)" event for result (.*) is reported$/ do |event, n|
  page.execute_script("if(window.jasmine){console.error('error: jasmine exists so analytics did not load')} else if (!window.GOVUK.analytics) { console.error('universal analytics has not loaded in yet')}")
  sought = "ec=#{event}&ea=#{n}"
  expect(browser_has_analytics_request_containing sought).to be(true)
end

Then /^the page view should be tracked$/ do
  page.execute_script("if(window.jasmine){console.error('error: jasmine exists so analytics did not load')} else if (!window.GOVUK.analytics) { console.error('universal analytics has not loaded in yet')}")
  sought = "t=pageview"
  expect(browser_has_analytics_request_containing sought).to be(true)
end

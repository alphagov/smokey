Then /^search analytics for "(.*)" are reported$/ do |term|
  sought = "dp=#{CGI::escape("/search/all?keywords=#{term.sub(' ', '+')}")}"
  wait_until { proxy_has_request_with_body_containing sought }
  expect(proxy_has_request_with_body_containing sought).to be(true)
end

Then /^the "(.*)" event is reported$/ do |event|
  sought = "ec=#{event}"
  wait_until { proxy_has_request_with_body_containing sought }
  expect(proxy_has_request_with_body_containing sought).to be(true)
end

Then /^the "(.*)" event for result (.*) is reported$/ do |event, n|
  sought = "ec=#{event}&ea=#{n}"
  wait_until { proxy_has_request_with_body_containing sought }
  expect(proxy_has_request_with_body_containing sought).to be(true)
end

Then /^the page view should be tracked$/ do
  sought = "t=pageview"
  wait_until { proxy_has_request_with_body_containing sought }
  expect(proxy_has_request_with_body_containing sought).to be(true)
end

def proxy_has_request_with_body_containing(sought)
  $proxy.har.entries.any? do |entry|
    request = entry.request

    return true if request.url.include?(sought)

    if request.body_size.positive?
      return true if request.post_data.text.include?(sought)
    end
  end
end

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

def proxy_has_request_with_body_containing(sought)
  $proxy.har.entries.any? do |e|
    if e.request.body_size.positive?
      e.request.post_data.text.include?(sought)
    end
  end
end

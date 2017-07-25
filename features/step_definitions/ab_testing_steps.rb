GOOGLE_ANALYTICS_PAGE_VIEW_URL_MATCHER = %r{google-analytics.com/r/collect\?.*t=pageview}

Given(/^there is an AB test setup$/) do
  # Empty step.
  # We assume that there is always an A/B test set up on the example A/B test
  # page. If this is not true, the A/B smoke tests will fail, so we should fix
  # or delete them as appropriate.
end

Given(/^I do not have any AB testing cookies set$/) do
  assert_equal(
    {},
    page.driver.cookies,
    "There should be no cookies set"
  )
end

Given(/^I am in the "(A|B)" group for "(.*)" AB testing$/) do |test_group, ab_test|
  # Set BOTH the cookie and the header, because:
  # - On development/int/staging, cookies don't work so use the header directly
  # - On production, the header is ignored and overwritten by the CDN, but honours the cookie
  page.driver.set_cookie("ABTest-#{ab_test}", test_group)
  page.driver.add_headers("GOVUK-ABTest-#{ab_test}" => test_group)
end

Then(/^we have shown them all versions of the AB test$/) do
  buckets = @responses.map { |r| ab_bucket(r.body) }.to_set
  buckets.should == (Set.new ["A", "B"])
end

Then(/^I am assigned to a test bucket$/) do
  ab_cookie = page.driver.cookies["ABTest-Example"]
  @ab_cookie_value = ab_cookie.value

  assert @ab_cookie_value == "A" || @ab_cookie_value == "B",
    "Expected A/B cookie to have value 'A' or 'B' but got '#{@ab_cookie_value}'"

  refute_nil ab_cookie.expires, "A/B cookie has no expiry time"
end

Then(/^I can see the bucket I am assigned to$/) do
  bucket = ab_bucket(page.body)
  assert bucket == "A" || bucket == "B",
    "Expected A/B bucket to be 'A' or 'B', but got '#{bucket}'"

  # Store bucket so that subsequent responses can be compared to the original
  @original_bucket = bucket
end

Then(/^the bucket is reported to Google Analytics$/) do
  analytics = []

  Timeout.timeout(Capybara.default_max_wait_time) do
    analytics = page_track_requests until analytics.length > 0
  end

  assert analytics.length == 1, "Expected exactly 1 page track request"

  query = Rack::Utils.parse_query URI(analytics.first.url).query

  query['cd40'].should == "Example:#{@ab_cookie_value}"
end

Then(/^I stay on the same bucket when I keep visiting "(.*?)"$/) do |path|
  20.times do
    request_options = default_request_options.merge(cookies: {"ABTest-Example": @ab_cookie_value})
    response = get_request("#{@host}#{path}", request_options)

    ab_bucket(response.body).should == @original_bucket
  end
end

def ab_bucket page
  Nokogiri::HTML.parse(page).css(".ab-example-group").text.strip
end

def page_track_requests
  page.driver.network_traffic.select { |traffic| traffic.url =~ GOOGLE_ANALYTICS_PAGE_VIEW_URL_MATCHER}
end

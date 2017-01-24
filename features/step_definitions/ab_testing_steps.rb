Given(/^there is an AB test setup$/) do
  # Empty step.
  # We assume that there is always an A/B test set up on the example A/B test
  # page. If this is not true, the A/B smoke tests will fail, so we should fix
  # or delete them as appropriate.
end

Given(/^I do not have any AB testing cookies set$/) do
  # Empty step.
  # By default, no cookies are set.
end

Then(/^we have shown them all versions of the AB test$/) do
  buckets = @responses.map { |r| ab_bucket(r.body) }.to_set
  buckets.should == (Set.new ["A", "B"])
end

Then(/^I am assigned to a test bucket$/) do
  ab_cookies = @response.headers[:set_cookie]
    .select { |h| h.start_with? "ABTest-Example=" }
  assert_equal 1, ab_cookies.length,
    "Expected response to set exactly one A/B test cookie"

  ab_cookie = ab_cookies[0]
  @ab_cookie_value = /ABTest-Example=([^;]*);/.match(ab_cookie)[1]

  assert @ab_cookie_value == "A" || @ab_cookie_value == "B",
    "Expected A/B cookie to have value 'A' or 'B' but got '#{@ab_cookie_value}'"

  assert ab_cookie.include?("expires="), "A/B cookie has no expiry time"
end

Then(/^I can see the bucket I am assigned to$/) do
  bucket = ab_bucket(@response.body)
  assert bucket == "A" || bucket == "B",
    "Expected A/B bucket to be 'A' or 'B', but got '#{bucket}'"

  # Store bucket so that subsequent responses can be compared to the original
  @original_bucket = bucket
end

Then(/^the bucket is reported to Google Analytics$/) do
  # FIXME: Implement once we know how we're reporting to GA. Is it sufficient to
  # check the meta tag which is inspected by GA to report the page view?
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

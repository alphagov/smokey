Given(/^there is an A\/B test set up$/) do
  # Empty step.
  # We assume that there is always an A/B test set up on the example A/B test
  # page. If this is not true, the A/B smoke tests will fail, so we should fix
  # or delete them as appropriate.
end

Given(/^I do not have any A\/B testing cookies set$/) do
  Capybara.current_session.driver.browser.manage.all_cookies.each do |cookie|
    refute_equal(
      "ABTest-Example",
      cookie[:name],
      "There should be no A/B cookies set"
    )
  end
end

Then(/^we have shown them all versions of the A\/B test$/) do
  buckets = @responses.map { |r| ab_bucket(r.body) }.to_set
  expect(buckets).to eq(Set.new ["A", "B"])
end

Then(/^I am assigned to a test bucket$/) do
  ab_cookie = Capybara
    .current_session
    .driver
    .browser
    .manage
    .cookie_named("ABTest-Example")

  @ab_cookie_value = ab_cookie[:value]

  assert @ab_cookie_value == "A" || @ab_cookie_value == "B",
    "Expected A/B cookie to have value 'A' or 'B' but got '#{@ab_cookie_value}'"

  refute_nil ab_cookie[:expires], "A/B cookie has no expiry time"
end

Then(/^I can see the bucket I am assigned to$/) do
  bucket = ab_bucket(page.body)
  assert bucket == "A" || bucket == "B",
    "Expected A/B bucket to be 'A' or 'B', but got '#{bucket}'"

  # Store bucket so that subsequent responses can be compared to the original
  @original_bucket = bucket
end

Then(/^the bucket is reported to Google Analytics$/) do
  sought = "cd40=Example%3A#{@ab_cookie_value}"
  expect(browser_has_analytics_request_containing sought).to be(true)
end

Then(/^I stay on the same bucket when I keep visiting "(.*?)"$/) do |path|
  20.times do
    request_options = default_request_options.merge(cookies: {"ABTest-Example": @ab_cookie_value})
    response = get_request("#{@host}#{path}", request_options)

    expect(ab_bucket(response.body)).to eq(@original_bucket)
  end
end

def ab_bucket page
  Nokogiri::HTML.parse(page).css(".ab-example-group").text.strip
end

Given(/^I do not have any A\/B testing cookies set$/) do
  all_cookies = Capybara
    .current_session
    .driver
    .browser
    .manage
    .all_cookies
    .map { |cookie| cookie[:name] }

  expect(all_cookies).to_not include("ABTest-Example")
end

When(/^multiple new users visit "(.*?)"$/) do |path|
  @responses = []
  20.times do
    @responses << get_request("#{@host}#{path}", default_request_options)
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

  expect(["A", "B"]).to include(ab_cookie[:value])
  expect(ab_cookie[:expires]).to_not be_nil
  @ab_cookie_value = ab_cookie[:value]
end

Then(/^I can see the bucket I am assigned to$/) do
  bucket = ab_bucket(page.body)
  expect(["A", "B"]).to include(bucket)

  # Store bucket so that subsequent responses can be compared to the original
  @original_bucket = bucket
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

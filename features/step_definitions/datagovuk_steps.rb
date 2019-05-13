When /^I search for "(.*)" in datasets$/ do |term|
  visit_path "#{@host}/search?q=#{term}"
end

Then /^I should see some dataset results$/ do
  result_links = page.all(".dgu-results__result")
  expect(result_links.count).to be >= 1
end

When /^I save the dataset count$/ do
  json = JSON.parse(@response.body)
  @package_count = json.fetch("result").fetch("count")
end

Then /^I should see a similar dataset count$/ do
  count_span = page.first(".dgu-results__summary span.bold-small")
  count = count_span.text.gsub(/[^\d^\.]/, '').to_i

  # to account for a delay in the sync between CKAN and Find, we only check
  # that the counts are similar, and not exactly the same
  expect(count).to be_within(25).of(@package_count)
end

Then /^I should see an accurate dataset count$/ do
  count_span = page.first(".dgu-results__summary span.bold-small")
  count = count_span.text.gsub(/[^\d^\.]/, '').to_i

  # this is correct as of the 26th April 2019, we might need to increase this
  # number in the future if more datasets are published
  expect(count).to be_within(1500).of(52823)
end

When /^I preview an organogram$/ do
  visit_path "#{@host}/dataset/7d114298-919b-4108-9600-9313e34ce3b8/organogram-of-staff-roles-salaries-september-2018/datafile/83a8d9f0-2d7c-433b-96f3-77866cddf058/preview"
end

And /^I don't get any s3 CSP errors$/ do
  messages = Capybara.current_session.driver.browser.manage.logs.get(:browser).map(&:message)
  regex = /Refused to connect to 'https:\/\/s3.*because it violates the following Content Security Policy directive: "connect-src/
  messages.each do |message|
    expect(message).to_not match(regex)
  end
end

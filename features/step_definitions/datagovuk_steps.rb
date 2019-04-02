When /^I search for "(.*)" in datasets$/ do |term|
  visit_path "#{@host}/search?q=#{term}"
end

Then /^I should see some dataset results$/ do
  result_links = page.all(".dgu-results__result")
  expect(result_links.count).to be >= 1
end

When /^I save the dataset count$/ do
  json = JSON.parse(@response.body)
  @package_count = json.fetch("result").count
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

  # this is correct as of the 2nd April 2019, we might need to increase this
  # number in the future if more datasets are published
  expect(count).to be_within(1000).of(49557)
end

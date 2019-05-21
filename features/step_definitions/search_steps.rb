When /^I search for "(.*)"$/ do |term|
  visit_path "/search?q=#{term}"
end

When /^I expand the search options$/ do
  click_link "+ Show more search options"
end

When /^I go to the next page$/ do
  click_link "Next page"
end

When /^I click result (.*)$/ do |n|
  result = page.all(".finder-results li a")[n.to_i - 1]
  click_link result.text
end

Then /^I should see some search results$/ do
  result_links = page.all(".finder-results li a")
  expect(result_links.count).to be >= 1
end

Then /^I should see organisations in the organisation filter$/ do
  organisation_options = page.all("#organisations.js-options-container input", visible: false)
  expect(organisation_options.count).to be >= 10
end

And /^the search results should be unique$/ do
  results = []
  page.all(".finder-results li a").each_with_index do |item, idx|
    results << item.text + page.all(".finder-results li p")[idx].text
  end
  expect(results.uniq.count).to eq(results.count)
end

And /^search analytics for "(.*)" are reported$/ do |term|
  found = false
  sought = "dp=#{CGI::escape("/search/all?keywords=#{term.sub(' ', '+')}")}"
  @@proxy.har.entries.each do |e|
    found = true if e.request.url.include? sought
  end
  expect(found).to be(true)
end

Then /^the "(.*)" event is reported$/ do |event|
  found = false
  sought = "eventCategory=#{event}"
  @@proxy.har.entries.each do |e|
    found = true if e.request.url.include? sought
  end
  expect(found).to be(true)
end

Then /^the "(.*)" event for result (.*) is reported$/ do |event, n|
  found = false
  sought = "eventCategory=#{event}&eventAction=Search.#{n}"
  @@proxy.har.entries.each do |e|
    found = true if e.request.url.include? sought
  end
  expect(found).to be(true)
end

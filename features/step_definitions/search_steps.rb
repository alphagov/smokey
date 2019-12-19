When /^I search for "(.*)"$/ do |term|
  visit_path "/search?q=#{term}"
end

When /^I expand the search options$/ do
  click_button "+ Show more search options"
end

When /^I go to the next page$/ do
  click_link "Next page"
end

When /^I click result (.*)$/ do |num|
  result = page.all(".finder-results li a")[num.to_i - 1]
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

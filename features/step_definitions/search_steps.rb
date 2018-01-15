When /^I search for "(.*)"$/ do |term|
  visit_path "/search?q=#{term}"
end

Then /^I should see some search results$/ do
  result_links = page.all(".results-list li a")
  result_links.count.should >= 1
end

Then /^I should see organisations in the organisation filter$/ do
  organisation_options = page.all("#organisations.options-container input", visible: false)
  organisation_options.count.should >= 10
end

And /^the search results should be unique$/ do
  results = []
  page.all(".results-list li a").each_with_index do |item, idx|
    results << item.text + page.all(".results-list li p")[idx].text
  end
  expect(results.uniq.count).to eq(results.count)
end

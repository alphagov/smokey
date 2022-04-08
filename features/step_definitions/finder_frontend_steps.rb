Then /^I should see an input field to search$/ do
  expect(page.body).to have_field('keywords')
end

Then(/^I should see filtered documents$/) do
  result_links = page.all(".filtered-results li a")
  expect(result_links.count).to be >= 1
end

And /^I should see an? (open|closed) facet titled "(.*?)" with non-blank values$/ do |open_closed, title|
  facet = page.find('.app-c-option-select') { |elem| elem.find('.js-container-button').has_text?(title)}

  if open_closed == "open"
    expect(facet[:class].split(" ")).not_to include("js-closed")
  else
    expect(facet[:class].split(" ")).to include("js-closed")

    # Facet options don't exist when you're not looking at them :(
    facet.find('button').click
  end

  labels = facet.all('.js-options-container label').map(&:text)
  blank_labels = labels.select { |label| label.strip.empty? }

  expect(labels).not_to be_empty
  expect(blank_labels).to be_empty
end

When /^I search for "(.*)"$/ do |term|
  visit_path "/search?q=#{term}"
end

When /^I go to the next page$/ do
  click_link "Next page"
end

When /^I click result (.*)$/ do |num|
  all(".finder-results li a.gem-c-document-list__item-title")[num.to_i - 1].click
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

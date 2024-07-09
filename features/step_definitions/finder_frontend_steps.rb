Then /^I should see an input field to search$/ do
  expect(page.body).to have_field('keywords')
end

When /^I search for "(.*)"$/ do |term|
  visit_path "/search?q=#{term}"
end

When /^I go to the next page$/ do
  click_link "Next page"
end

When /^I click result (.*)$/ do |num|
  all(".finder-results li .gem-c-document-list__item-title a")[num.to_i - 1].click
end

Then /^I should see some search results$/ do
  result_links = page.all(".finder-results li a")
  expect(result_links.count).to be >= 1
end

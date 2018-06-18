Then /^I should see an input field to search$/ do
  page.body.should have_field('keywords')
end

Then(/^I should see filtered documents$/) do
  result_links = page.all(".filtered-results li a")
  result_links.count.should >= 1
end

And /^I should see an? (open|closed) facet titled "(.*?)" with non-blank values$/ do |open_closed, title|
  facet = page.find('.app-c-option-select') { |elem| elem.find('.js-container-head').has_text?(title)}

  if open_closed == "open"
    expect(facet[:class].split(" ")).not_to include("js-closed")
  else
    expect(facet[:class].split(" ")).to include("js-closed")

    # Facet options don't exist when you're not looking at them :(
    facet.find('button').click
  end

  labels = facet.all('.options-container label').map(&:text)
  blank_labels = labels.select { |label| label.strip.empty? }

  expect(labels).not_to be_empty
  expect(blank_labels).to be_empty
end

Then(/^I should see "([^"]*)" in the result\-info class$/) do |malicious_code|
   expect(page).to have_css(".result-info", text: malicious_code)
end

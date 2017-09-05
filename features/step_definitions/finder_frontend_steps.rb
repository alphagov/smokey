Then /^I should see an input field to search$/ do
  page.body.should have_field('keywords')
end

And /^I should see an? (open|closed) facet titled "(.*?)" with non-blank values$/ do |open_closed, title|
  facet = page.find('.govuk-option-select') { |elem| elem.find('.js-container-head').has_text?(title)}

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

Then /^I should see the next closing box$/ do
  expect(page).to have_css(".gem-c-inset-text")
end

And /^it should be populated$/ do
  within ".gem-c-inset-text.govuk-inset-text" do
    expect(page).to have_css(".govuk-body")
    @title = find(:xpath, "p").native.text
  end
end

When /^I click the next closing response link$/ do
  within ".gem-c-inset-text > div > .govuk-link" do
    click_link "Read and respond"
  end
end

Then /^I should see the next closing consultation$/ do
  expect(page).to have_content(@title)
end

And /^it should be populated with three open consultations$/ do
  within ".get-involved > div:nth-child(4) > div" do
    expect(page).to have_css(".gem-c-document-list__item-title", count: 3)
  end
end

And /^it should be populated with three closed consultations$/ do
  within ".get-involved > div:nth-child(5) > div" do
    expect(page).to have_css(".gem-c-document-list__item-title", count: 3)
  end
end

Then /^I should see the search link "(.*?)"$/ do |link|
  expect(page).to have_content(link)
  @linktext = link
end

And /^it should link to "(.*?)"$/ do |link|
  have_link(@linktext, :href => link)
end


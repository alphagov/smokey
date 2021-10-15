Then /^I should see the next closing box$/ do
  expect(page).to have_css(".consultation-closing-soon")
end

And /^it should be populated$/ do
  within ".consultation-closing-soon .document-row" do
    expect(page).to have_css("h3")
    @title = find(:xpath, "h3").native.text
  end
end

When /^I click the next closing response link$/ do
  within ".consultation-closing-soon" do
    click_link "Read and respond"
  end
end

Then /^I should see the next closing consultation$/ do
  expect(page).to have_content(@title)
end

And /^it should be populated with three open consultations$/ do
  within ".recently-opened" do
    expect(page).to have_css("#consultation-title", count: 3)
  end
end

And /^it should be populated with three closed consultations$/ do
  within ".recent-outcomes" do
    expect(page).to have_css("#consultation-title", count: 3)
  end
end

Then /^I should see the search link "(.*?)"$/ do |link|
  expect(page).to have_content(link)
  @linktext = link
end

And /^it should link to "(.*?)"$/ do |link|
  have_link(@linktext, :href => link)
end


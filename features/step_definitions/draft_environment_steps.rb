When /^I attempt to go to a case study$/ do
  visit_path "government/case-studies/example-case-studies-eu-citizens-rights-in-the-uk"
end

When /^I attempt to visit "(.*?)"$/ do |path|
  visit_path path
end

Then /^I should be prompted to log in$/ do
  expect(page).to have_content('Sign in')
end

When /^I log in using valid credentials$/ do
  fill_in "Email", :with => ENV["SIGNON_EMAIL"]
  fill_in "Password", :with => ENV["SIGNON_PASSWORD"]
  click_button "Sign in"
end

Then /^I should be on the case study page$/ do
  expect(page.current_path).to eq("/government/case-studies/example-case-studies-eu-citizens-rights-in-the-uk")
  expect(page).to have_content('Case study')
end

Then /^the page should contain the draft watermark$/ do
  puts page
  expect(page).to have_css('body.draft')
end

Then /^I should see the draft image asset$/ do
  image_src = page.find('img')['src']
  expect(image_src).to have_content('draft-assets')
  expect(image_src).to have_content('.jpg')
end

When /^I attempt to go to a case study$/ do
  visit_path "government/case-studies/loopwheels-delivering-a-smoother-ride-for-wheelchair-users"
end

When /^I attempt to visit "(.*?)"$/ do |path|
  visit_path path
end

When /^I attempt to visit a CMA case$/ do
  visit_path "cma-cases/japan-tobacco-international-e-lites"
end

When /^I attempt to visit a manual$/ do
  visit_path "guidance/content-design"
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
  expect(page.current_path).to eq("/government/case-studies/loopwheels-delivering-a-smoother-ride-for-wheelchair-users")
  expect(page).to have_content('Case study')
end

Then /^the page should contain the draft watermark$/ do
  expect(page).to have_css('body.draft')
end

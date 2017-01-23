When /^I attempt to go to a case study$/ do
  visit_path "government/case-studies/epic-cic"
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
  page.should have_content('Sign in')
end

When /^I log in using valid credentials$/ do
  fill_in "Email", :with => ENV["SIGNON_EMAIL"]
  fill_in "Passphrase", :with => ENV["SIGNON_PASSWORD"]
  click_button "Sign in"
end

Then /^I should be on the case study page$/ do
  page.current_path.should eq("/government/case-studies/epic-cic")
  page.should have_content('Case study')
end

Then /^the page should contain the draft watermark$/ do
  page.should have_css('body.draft')
end

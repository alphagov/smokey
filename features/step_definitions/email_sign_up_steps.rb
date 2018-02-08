Then /^I should see a create subscription button$/ do
  expect(page).to have_selector("button", text: "Create subscription")
end

When /^I choose radio button "(.*?)" and click on "(.*?)"$/ do |option, button_text|
  choose(option, visible: false)
  button_click(button_text)
end

When /^I input "(.*)" and click subscribe$/ do |email|
  fill_in('address', with: 'email@email.com')
  button_click('Subscribe')
end

When /^I click on the link with path "(.*?)"$/ do |href|
  #either this way or individual css selector for two entry email links?
  link = find(:xpath, "//a[@href='#{href}']")
  link.should_not == nil
  step "I visit \"#{href}\""
end

When /^I choose the checkbox "(.*)" and click on "(.*)"$/ do |option, button_text|
  check(option, visible: false)
  button_click(button_text)
end

When /^I click on the button "(.*?)"$/ do |button_text|
  button = Nokogiri::HTML.parse(page.body)
           .at_xpath("//button[normalize-space(text() = '#{button_text}')]")
  button.should_not == nil
  button_click(button_text)
end

def button_click(button_text)
  click_button button_text
end

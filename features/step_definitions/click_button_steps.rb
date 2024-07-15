When /^I choose radio button "(.*?)" and click on "(.*?)"$/ do |option, button_text|
  choose(option, visible: false, allow_label_click: true)
  step "I click on the button \"#{button_text}\""
end

When /^I click on the link "(.*?)"$/ do |link_text|
  click_link link_text, match: :first
end

When /^I choose the checkbox "(.*)" and click on "(.*)"$/ do |option, button_text|
  check(option, visible: false, allow_label_click: true)
  step "I click on the button \"#{button_text}\""
end

When /^I click on the button "(.*?)"$/ do |button_text|
  click_button button_text
end

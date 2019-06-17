When /^I input malicious code in the (.*) field$/ do |field|
  page.execute_script('$("form").attr("novalidate", "novalidate")')
  find(".email").set("<script>alert(document.cookie)</script>")
  click_button("Send message")
end

Then /^I see the code returned in the page$/ do
  expect(page).to have_selector("input[value='<script>alert(document.cookie)</script>']")
end

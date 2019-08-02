When /^I input malicious code in the (.*) field$/ do |field|
  page.execute_script('$("form").attr("novalidate", "novalidate")')
  find(".email").set("<script>alert(document.cookie)</script>")
  click_button("Send message")
end

When /^I click to say the page is not useful$/ do
  within(".gem-c-feedback") do
    click_on("No")
  end
end

When /^I submit the email survey signup form$/ do
  within(".gem-c-feedback") do
    fill_in "Email address", with: "name@example.com"
    click_on "Send me the survey"
  end
end

Then /^I see a signup confirmation message$/ do
  expect(page).to have_content("Thank you for your feedback")
end

Then /^I see the code returned in the page$/ do
  expect(page).to have_selector("input[value='<script>alert(document.cookie)</script>']")
end

Then /^a request is sent to the feedback app$/ do
  sought = "/contact/govuk/email-survey-signup"
  wait_until { proxy_has_request_with_url_containing sought }
  expect(proxy_has_request_with_url_containing sought).to be(true)
end

def proxy_has_request_with_url_containing(sought)
  $proxy.har.entries.any? do |e|
    e.request.url.include? sought
  end
end

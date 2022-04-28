When /^I input malicious code in the (.*) field$/ do |field|
  page.execute_script("document.querySelector('.contact-form').setAttribute('novalidate', 'novalidate')")
  find("#email").set("<script>alert(document.cookie)</script>")
  click_button("Send message")
end

When /^I click to report a problem with the page$/ do
  within(".gem-c-feedback") do
    click_on("Report a problem with this page")
  end
end

Then /^I see the report a problem form$/ do
  within(".gem-c-feedback") do
    expect(page).to have_content("Help us improve GOV.UK")
    expect(page).to have_field("What went wrong?")

    # Regression test for scenario where wrong URL is set
    url_input = page.find("form[action='/contact/govuk/problem_reports'] input[name=url]", visible: false)
    expect(url_input.value).to eq(page.current_url)
  end
end

When /^I close the open feedback form$/ do
  within(".gem-c-feedback") do
    click_on("Close")
  end
end

When /^I click to say the page is not useful$/ do
  within(".gem-c-feedback") do
    click_on("No")
  end
end

When /^I click to say the page is useful$/ do
  within(".gem-c-feedback") do
    click_on("Yes")
  end
end

Then /^I see the email survey signup form$/ do
  within(".gem-c-feedback") do
    expect(page).to have_content("Help us improve GOV.UK")
    expect(page).to have_field("Email address")

    # Regression test for scenario where wrong URL is set
    url_input = page.find("form[action='/contact/govuk/email-survey-signup'] input[name='email_survey_signup[survey_source]']", visible: false)
    full_path = URI(page.current_url).request_uri
    expect(url_input.value).to eq(full_path)
  end
end

When /^I submit the email survey signup form$/ do
  within(".gem-c-feedback") do
    fill_in "Email address", with: "simulate-delivered@notifications.service.gov.uk"
    click_on "Send me the survey"
  end
end

Then /^I see the feedback confirmation message$/ do
  expect(page).to have_content("Thank you for your feedback")
end

Then /^I see the code returned in the page$/ do
  expect(page).to have_selector("input[value='<script>alert(document.cookie)</script>']")
end

Then /^a request is sent to the feedback app$/ do
  sought = "/contact/govuk/email-survey-signup"
  wait_until { found = browser_has_request_with_url_containing sought }
  expect(browser_has_request_with_url_containing sought).to be(true)
end

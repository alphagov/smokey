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
    url_input = page.find("form[action$='/contact/govuk/problem_reports'] input[name=url]", visible: false)
    expect(url_input.value).to eq(page.current_url)
  end
end

When /^I close the open feedback form$/ do
  within(".gem-c-feedback") do
    click_on("Cancel")
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

Then /^I see the feedback confirmation message$/ do
  expect(page).to have_content("Thank you for your feedback")
end

Then /^I see a survey link$/ do
  expect(page).to have_link("Please fill in this survey", href: /smartsurvey/)
end

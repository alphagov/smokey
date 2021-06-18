When "I sign in to my GOV.UK account" do
  assert ENV["GOVUK_ACCOUNT_EMAIL"] && ENV["GOVUK_ACCOUNT_PASSWORD"], "Please ensure that the GOV.UK account credentials are available in the environment"

  fill_in "Email address", :with => ENV["GOVUK_ACCOUNT_EMAIL"]
  fill_in "Password", :with => ENV["GOVUK_ACCOUNT_PASSWORD"]
  click_button "Continue"
end

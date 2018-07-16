When /^I login to Licensify$/ do
  visit_path application_external_url("licensify-admin")
  click_button "Login"
end

When /^I login to Licensify$/ do
  visit_path "https://licensify-admin.#{app_domain}/login"
  click_button 'Login'
end

When /^I login to Licensify$/ do
  visit_path "#{application_external_url('licensify-admin')}/login"
  click_button 'Login'
end

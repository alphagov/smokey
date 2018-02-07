When /^I login to Licensify$/ do
  visit_path "#{Plek.new.external_url_for('licensify-admin')}/login"
  click_button 'Login'
end

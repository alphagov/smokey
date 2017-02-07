When /^I login to Licensify$/ do
  visit "https://licensify-admin.#{ENV['GOVUK_APP_DOMAIN']}/login"
  click_button 'Login'
end

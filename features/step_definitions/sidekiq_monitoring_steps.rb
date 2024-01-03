When /^I go to the sidekiq-monitoring page for "(.*)"$/ do |term|
  visit_path "#{application_internal_url('sidekiq-monitoring')}/#{term}"
end

Then /^I should see the dashboard$/ do
  expect(govuk_page.body).to have_text('Dashboard')
end

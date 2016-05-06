When /^I visit the email campaign press release page$/ do
  if ENV['AUTH_USERNAME']
    page.driver.browser.agent.add_auth(ENV['GOVUK_WEBSITE_ROOT'], ENV['AUTH_USERNAME'], ENV['AUTH_PASSWORD'])
  end
  visit "#{ENV["GOVUK_WEBSITE_ROOT"]}/lloyds-share-offer"
end

When /^I visit the email campaign page$/ do
  if ENV['AUTH_USERNAME']
    page.driver.browser.agent.add_auth(ENV['GOVUK_WEBSITE_ROOT'], ENV['AUTH_USERNAME'], ENV['AUTH_PASSWORD'])
  end
  visit "#{ENV["GOVUK_WEBSITE_ROOT"]}/lloydsshares"
end

Then /^I should be asked to confirm my location$/ do
  page.should have_content("Choose your country of residence")
end

When /^I give my location as "(.*?)"$/ do |location|
  select(location, :from => 'Country')
  mechanize_with_referer do
    click_button 'Submit'
  end
end

Then /^I should see the press release$/ do
  page.should have_content("Government announces next steps on Lloyds retail sale")
end

When /^I follow the link to the campaign$/ do
  mechanize_with_referer do
    click_link 'www.gov.uk/lloydsshares'
  end
end

Then /^I should see the campaign page$/ do
  page.should have_content("Lloyds Banking Group share offer")
  page.should have_content("Register your interest in this share offer")
end

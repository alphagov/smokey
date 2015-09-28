require 'nokogiri'
require 'capybara/cucumber'
require 'capybara/mechanize'
require 'uri'
require 'plek'

ENV["GOVUK_WEBSITE_ROOT"] ||= "https://www.preview.alphagov.co.uk"
ENV["GOVUK_DRAFT_WEBSITE_ROOT"] ||= Plek.find('draft-origin')

case ENV["GOVUK_WEBSITE_ROOT"]
when "https://www.preview.alphagov.co.uk", "https://www-origin.staging.publishing.service.gov.uk"
  ENV["EXPECTED_GOVUK_WEBSITE_ROOT"] = ENV["GOVUK_WEBSITE_ROOT"]
else
  ENV["EXPECTED_GOVUK_WEBSITE_ROOT"] = 'https://www.gov.uk'
end

Capybara.default_driver = :mechanize
Capybara.app_host = ENV["GOVUK_WEBSITE_ROOT"]

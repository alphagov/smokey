require 'nokogiri'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'uri'
require 'plek'

ENV["GOVUK_WEBSITE_ROOT"] ||= "https://www-origin.integration.publishing.service.gov.uk"
ENV["GOVUK_DRAFT_WEBSITE_ROOT"] ||= Plek.find('draft-origin')

case ENV["GOVUK_WEBSITE_ROOT"]
when "https://www-origin.integration.publishing.service.gov.uk", "https://www-origin.staging.publishing.service.gov.uk"
  ENV["EXPECTED_GOVUK_WEBSITE_ROOT"] = ENV["GOVUK_WEBSITE_ROOT"]
else
  ENV["EXPECTED_GOVUK_WEBSITE_ROOT"] = 'https://www.gov.uk'
end

Capybara.app_host = ENV["GOVUK_WEBSITE_ROOT"]
Capybara.default_driver = :poltergeist

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
phantomjs_logger = File.open("log/phantomjs.log", "a")
ANALYTICS_URL = 'https://www.google-analytics.com'

Capybara.register_driver :poltergeist do |app|
  # TODO: We should log the output from PhantomJS. This is currently disabled
  # because the log format is causing errors with Monitoring
  # https://github.com/alphagov/smokey/pull/237
  Capybara::Poltergeist::Driver.new(app, phantomjs_logger: phantomjs_logger).tap do |driver|
    driver.browser.url_blacklist = [ANALYTICS_URL]
  end
end

Capybara.default_driver = :poltergeist

Around('@withanalitics') do |scenario, block|
  current_url_blacklist = page.driver.browser.url_blacklist
  page.driver.browser.url_blacklist = current_url_blacklist - ANALYTICS_URL

  block.call

  page.driver.browser.url_blacklist = current_url_blacklist
end

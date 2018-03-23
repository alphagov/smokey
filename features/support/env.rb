require 'nokogiri'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'uri'
require 'plek'

ENV["GOVUK_WEBSITE_ROOT"] ||= "https://www-origin.integration.publishing.service.gov.uk"
ENV["GOVUK_DRAFT_WEBSITE_ROOT"] ||= Plek.new.external_url_for('draft-origin')

non_production_website_roots = [
  "https://www-origin.integration.publishing.service.gov.uk",
  "https://www-origin.staging.publishing.service.gov.uk",
  "https://www-origin.integration.govuk.digital",
  "https://www-origin.blue.integration.govuk.digital",
  "https://www-origin.green.integration.govuk.digital",
  "https://www-origin.staging.govuk.digital",
  "https://www-origin.blue.staging.govuk.digital",
  "https://www-origin.green.staging.govuk.digital",
]

case ENV["GOVUK_WEBSITE_ROOT"]
when *non_production_website_roots
  ENV["EXPECTED_GOVUK_WEBSITE_ROOT"] = ENV["GOVUK_WEBSITE_ROOT"]
else
  ENV["EXPECTED_GOVUK_WEBSITE_ROOT"] = 'https://www.gov.uk'
end

Capybara.app_host = ENV["GOVUK_WEBSITE_ROOT"]
phantomjs_logger = File.open("log/phantomjs.log", "a")

GOOGLE_ANALYTICS_URL = 'www.google-analytics.com'
BLACKLISTED_URLS = [
  GOOGLE_ANALYTICS_URL,
  'www.youtube.com'
]

Capybara.register_driver :poltergeist do |app|
  options = {
    debug: ENV['POLTERGEIST_DEBUG'] || false,
    phantomjs_logger: phantomjs_logger,
    url_blacklist: BLACKLISTED_URLS
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.default_driver = :poltergeist

Before do
  page.driver.add_headers('User-Agent' => 'Smokey')
end

Before('@withanalytics') do |scenario, block|
  page.driver.browser.url_blacklist = BLACKLISTED_URLS - [GOOGLE_ANALYTICS_URL]
end

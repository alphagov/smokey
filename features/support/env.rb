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

BLACKLISTED_URLS = ['www.google-analytics.com']

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

After('~@withanalytics') do
  uris = page.driver.network_traffic.map(&:url)
  urls = uris.select { |uri| ['http', 'https'].include?(URI.parse(uri).scheme) }
  hosts = urls.map { |url| URI.parse(url).host }.uniq.sort

  if (BLACKLISTED_URLS - hosts).empty?
    raise "We should not contact Google Analytics. Please use @withanalytics if you need to."
  end
end

Before('@withanalytics') do |scenario, block|
  page.driver.browser.url_blacklist = []
end

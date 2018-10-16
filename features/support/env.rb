require 'browsermob/proxy'
require 'capybara/chromedriver/logger'
require 'capybara/cucumber'
require 'nokogiri'
require 'ptools'
require 'plek'
require 'selenium-webdriver'
require 'uri'

if ENV["AUTH_USERNAME"] && ENV["AUTH_PASSWORD"]
  basic_auth_credentials = "#{ENV['AUTH_USERNAME']}:#{ENV['AUTH_PASSWORD']}@"
end

# Set up environment
case ENV["ENVIRONMENT"]
when "integration"
  ENV["GOVUK_APP_DOMAIN"] ||= "integration.publishing.service.gov.uk"
  ENV["GOVUK_WEBSITE_ROOT"] ||= "https://www.integration.publishing.service.gov.uk"
  ENV["GOVUK_WEBSITE_ROOT_WITH_AUTH"] ||= "https://#{basic_auth_credentials}www.integration.publishing.service.gov.uk"
when "staging"
  ENV["GOVUK_APP_DOMAIN"] ||= "staging.publishing.service.gov.uk"
  ENV["GOVUK_WEBSITE_ROOT"] ||= "https://www.staging.publishing.service.gov.uk"
when "production"
  ENV["GOVUK_APP_DOMAIN"] ||= "publishing.service.gov.uk"
  ENV["GOVUK_WEBSITE_ROOT"] ||= "https://www.gov.uk"
else
  raise "ENVIRONMENT should be one of integration, staging or production"
end

# Set up basic URLs
ENV["GOVUK_DRAFT_WEBSITE_ROOT"] ||= Plek.new.external_url_for("draft-origin")
Capybara.app_host = ENV["GOVUK_WEBSITE_ROOT_WITH_AUTH"] || ENV["GOVUK_WEBSITE_ROOT"]

# Set up proxy server (used to manipulate HTTP headers etc since Selenium doesn't
# support this) on a random port between 3222 and 3229
proxy_port = (3222..3229).to_a.sample
server = BrowserMob::Proxy::Server.new("./bin/browsermob-proxy", port: proxy_port)
server.start
proxy = server.create_proxy

# Set up request logging and make it available across all tests
proxy.new_har
@@har = proxy.har

# Add request headers
if ENV["RATE_LIMIT_TOKEN"]
  proxy.header({ "Rate-Limit-Token" => ENV["RATE_LIMIT_TOKEN"] })
end

# Blacklist YouTube to prevent cross-site errors
proxy.blacklist(/^https:\/\/www\.youtube\.com/i, 200)
proxy.blacklist(/^https:\/\/s\.ytimg\.com/i, 200)

# Licensify admin doesn't have favicon.ico so block requests to prevent errors
proxy.blacklist(/^https:\/\/licensify-admin(.*)\.publishing\.service\.gov\.uk\/favicon\.ico$/i, 200)

chromedriver_from_path = File.which("chromedriver")

if chromedriver_from_path
  # Use the installed chromedriver, rather than chromedriver-helper
  Selenium::WebDriver::Chrome.driver_path = chromedriver_from_path
else
  require 'chromedriver-helper'
end

# Use Chrome in headless mode
Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    acceptInsecureCerts: true,
    loggingPrefs: { browser: "ALL" },
    proxy: { type: :manual, ssl: "#{proxy.host}:#{proxy.port}" }
  )

  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  options.add_argument("--disable-gpu")

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    desired_capabilities: capabilities
  )
end

Capybara.default_driver = :headless_chrome
Capybara.javascript_driver = :headless_chrome

# Only raise for severe JavaScript errors and filter our 404s and CORS messages
Capybara::Chromedriver::Logger.raise_js_errors = true
Capybara::Chromedriver::Logger.filter_levels = %i(debug info warning)
Capybara::Chromedriver::Logger.filters = [
  /Failed to load resource/i,
  /The target origin provided/i,
]

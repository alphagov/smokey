require 'capybara/chromedriver/logger'
require 'capybara/cucumber'
require 'plek'
require 'selenium-webdriver'
require 'uri'

# Set up environment
case ENV["ENVIRONMENT"]
when "integration"
  ENV["GOVUK_APP_DOMAIN"] ||= "integration.publishing.service.gov.uk"
  ENV["GOVUK_WEBSITE_ROOT"] ||= "https://www.integration.publishing.service.gov.uk"
when "staging"
  ENV["GOVUK_APP_DOMAIN"] ||= "staging.publishing.service.gov.uk"
  ENV["GOVUK_WEBSITE_ROOT"] ||= "https://www.staging.publishing.service.gov.uk"
when "production"
  ENV["GOVUK_APP_DOMAIN"] ||= "publishing.service.gov.uk"
  ENV["GOVUK_WEBSITE_ROOT"] ||= "https://www.gov.uk"
else
  raise "ENVIRONMENT should be one of integration, staging, production"
end

# Set up basic URLs
Capybara.app_host = ENV["GOVUK_WEBSITE_ROOT"]

# Use Chrome in headless mode
Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    acceptInsecureCerts: true,
    'goog:loggingPrefs': {
      browser: "ALL",
      performance: "ALL"
    },
  )

  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  options.add_argument("--disable-gpu")
  options.add_argument("--disable-xss-auditor")
  options.add_argument("--user-agent=Smokey\ Test\ \/\ Ruby")
  options.add_argument("--no-sandbox") if ENV.key?("NO_SANDBOX")

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

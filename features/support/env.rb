require 'capybara'
require 'capybara/cucumber'
require 'govuk_app_config/govuk_error'
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

# Set up error reporting (using SENTRY_CURRENT_ENV for the environment).
GovukError.configure

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new.tap do |chrome_options|
    chrome_options.add_argument("--headless=new")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument('--remote-debugging-pipe')
    # Note: the user agent is being used to filter GA4 data from production in govuk_publishing_components
    chrome_options.add_argument("--user-agent='Smokey Test / Ruby'")
    chrome_options.add_option(
      "goog:loggingPrefs", { performance: "ALL", browser: "ALL" }
    )
  end

  service = Selenium::WebDriver::Service.chrome(
    args: [
      ("--verbose" if ENV.key?("CHROMEDRIVER_VERBOSE")),
      "--log-path=#{ENV.fetch("CHROMEDRIVER_LOG_FILE", "/tmp/chromedriver.log")}",
    ].compact,
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options:,
    service: service,
  )
end

Capybara.default_driver = :headless_chrome
Capybara.javascript_driver = :headless_chrome

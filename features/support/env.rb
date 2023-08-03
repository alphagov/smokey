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
  options = Selenium::WebDriver::Chrome::Options.new
  options.headless!
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--disable-extensions")
  options.add_argument("--disable-gpu")
  options.add_argument("--disable-web-security")
  options.add_argument("--disable-xss-auditor")
  options.add_argument("--user-agent='Smokey Test / Ruby'")
  options.add_argument("--no-sandbox") if ENV.key?("NO_SANDBOX")
  options.add_argument("--ignore-certificate-errors") if ENV.key?("CHROME_ACCEPT_INSECURE_CERTS")
  options.add_option(
    "goog:loggingPrefs", { performance: "ALL", browser: "ALL" }
  )

  service = Selenium::WebDriver::Service.chrome(
    args: {
      verbose: ENV.key?("CHROMEDRIVER_VERBOSE"),
      log_path: ENV.fetch("CHROMEDRIVER_LOG_FILE", "/tmp/chromedriver.log"),
    },
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    service: service,
  )
end

Capybara.default_driver = :headless_chrome
Capybara.javascript_driver = :headless_chrome

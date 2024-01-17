require 'capybara/cucumber'
require 'govuk_app_config/govuk_error'
require 'plek'
require 'selenium-webdriver'
require 'uri'
require_relative './env_vars'

# Set up error reporting (using SENTRY_CURRENT_ENV for the environment).
GovukError.configure

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless=new")
  options.add_argument("--disable-dev-shm-usage")
  options.add_argument("--disable-extensions")
  options.add_argument("--disable-gpu")
  options.add_argument("--disable-web-security")
  options.add_argument("--disable-xss-auditor")
  # Note: the user agent is being used to filter GA4 data from production in govuk_publishing_components
  options.add_argument("--user-agent='Smokey Test / Ruby'")
  options.add_argument("--no-sandbox") if ENV.key?("NO_SANDBOX")
  options.add_argument("--ignore-certificate-errors") if ENV.key?("CHROME_ACCEPT_INSECURE_CERTS")
  options.add_option(
    "goog:loggingPrefs", { performance: "ALL", browser: "ALL" }
  )

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

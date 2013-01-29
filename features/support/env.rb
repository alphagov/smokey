require 'nokogiri'
require 'capybara/cucumber'
require 'capybara/mechanize'

def base_url
  ENV["GOVUK_WEBSITE_ROOT"] || "https://www.preview.alphagov.co.uk"
end

Capybara.default_driver = :mechanize
Capybara.app_host = base_url

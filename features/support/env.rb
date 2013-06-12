require 'nokogiri'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'capybara/mechanize'

def base_url
  ENV["GOVUK_WEBSITE_ROOT"] || "https://www.preview.alphagov.co.uk"
end

# Capybara.register_driver :poltergeist do |app|
  # Capybara::Poltergeist::Driver.new(app, debug: true)
# end
Capybara.register_driver :poltergeist
Capybara.default_driver = :mechanize
Capybara.app_host = base_url

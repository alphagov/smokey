require 'nokogiri'
require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'capybara/mechanize'

def base_url
  ENV["GOVUK_WEBSITE_ROOT"] || "https://www.preview.alphagov.co.uk"
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, window_size: [1200, 768])
end
Capybara.default_driver = :mechanize
Capybara.app_host = base_url

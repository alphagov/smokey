require 'nokogiri'
require 'capybara/cucumber'
require 'capybara/mechanize'

Capybara.default_driver = :mechanize
Capybara.app_host = base_url

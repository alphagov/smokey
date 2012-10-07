# require 'webrat'

# Webrat.configure do |config|
#   config.mode = :mechanize
# end

# World(Webrat::Methods)
# World(Webrat::Matchers)
require 'nokogiri'
require 'capybara/cucumber'
require 'capybara/mechanize'

Capybara.default_driver = :mechanize
Capybara.app_host = base_url

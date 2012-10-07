# require 'webrat'

# Webrat.configure do |config|
#   config.mode = :mechanize
# end

# World(Webrat::Methods)
# World(Webrat::Matchers)
require 'nokogiri'
require 'capybara/cucumber'
require 'capybara/mechanize'

def target_platform
  ENV["TARGET_PLATFORM"] || "preview"
end

def base_url
  if target_platform == "production"
    "https://www.gov.uk"
  else
    "https://www.#{target_platform}.alphagov.co.uk"
  end
end

Capybara.default_driver = :mechanize
Capybara.app_host = base_url
Capybara::Mechanize.local_hosts << "publisher.#{target_platform}.alphagov.co.uk"
Capybara::Mechanize.local_hosts << "panopticon.#{target_platform}.alphagov.co.uk"
Capybara::Mechanize.local_hosts << "signon.#{target_platform}.alphagov.co.uk"
require 'nokogiri'
require 'capybara/cucumber'
require 'capybara/mechanize'
require 'uri'

def guess_draft_url_from_live(live_url)
  url = URI.parse(live_url)
  host = (["draft-origin"] + url.host.split(".")[1..-1]).join(".")
  "#{url.scheme}://#{host}"
end

ENV["GOVUK_WEBSITE_ROOT"] ||= "https://www.preview.alphagov.co.uk"
ENV["GOVUK_DRAFT_WEBSITE_ROOT"] ||= guess_draft_url_from_live(ENV["GOVUK_WEBSITE_ROOT"])

Capybara.default_driver = :mechanize
Capybara.app_host = ENV["GOVUK_WEBSITE_ROOT"]

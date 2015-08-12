require 'nokogiri'
require 'capybara/cucumber'
require 'capybara/mechanize'
require 'uri'
require 'plek'

ENV["GOVUK_WEBSITE_ROOT"] ||= "https://www.preview.alphagov.co.uk"
ENV["GOVUK_DRAFT_WEBSITE_ROOT"] ||= Plek.find('draft-origin')

Capybara.default_driver = :mechanize
Capybara.app_host = ENV["GOVUK_WEBSITE_ROOT"]

# Set up environment
case ENV["ENVIRONMENT"]
when "integration"
  ENV["GOVUK_APP_DOMAIN"] ||= "integration.publishing.service.gov.uk"
  ENV["GOVUK_WEBSITE_HOST"] ||= "www.integration.publishing.service.gov.uk"
  ENV["PROXY_PROFILE"] ||= "primaryCDN"
when "staging"
  ENV["GOVUK_APP_DOMAIN"] ||= "staging.publishing.service.gov.uk"
  ENV["GOVUK_WEBSITE_HOST"] ||= "www.staging.publishing.service.gov.uk"
  ENV["PROXY_PROFILE"] ||= "primaryCDN"
when "production"
  ENV["GOVUK_APP_DOMAIN"] ||= "publishing.service.gov.uk"
  ENV["GOVUK_WEBSITE_HOST"] ||= "www.gov.uk"
  ENV["PROXY_PROFILE"] ||= "primaryCDN"
else
  raise "ENVIRONMENT should be one of integration, staging, production"
end

ENV["GOVUK_WEBSITE_ROOT"] = "http://127.0.0.1:8080"

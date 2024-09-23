When /^I visit the GOV.UK Chat about page$/ do
  url = if ENV["ENVIRONMENT"] == "production"
    application_external_url("chat")
  else
    application_internal_url("chat")
  end

  cache_busted_url = cache_bust("#{url}/chat/about")

  step "I visit \"#{cache_busted_url}\""
end

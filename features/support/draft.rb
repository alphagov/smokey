Around('@draft') do |scenario, block|
  old_app_host = Capybara.app_host
  begin
    Capybara.app_host = ENV.fetch('GOVUK_DRAFT_WEBSITE_ROOT')
    block.call
  ensure
    Capybara.app_host = old_app_host
  end
end

Around('@draft-assets') do |scenario, block|
  old_app_host = Capybara.app_host
  begin
    Capybara.app_host = application_external_url("draft-assets")
    block.call
  ensure
    Capybara.app_host = old_app_host
  end
end

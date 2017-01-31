Before do
  if ENV['RATE_LIMIT_TOKEN']
    page.driver.header 'Rate-Limit-Token', ENV['RATE_LIMIT_TOKEN']
  end
end

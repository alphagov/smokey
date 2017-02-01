Before do
  if ENV['RATE_LIMIT_TOKEN']
    page.driver.add_headers 'Rate-Limit-Token' => ENV['RATE_LIMIT_TOKEN']
  end
end

Before do
  page.driver.browser.agent.pre_connect_hooks << proc { |agent, request|
    rate_limit_token = ENV['RATE_LIMIT_TOKEN']
    if rate_limit_token
      request["Rate-Limit-Token"] = rate_limit_token
    end
  }
end

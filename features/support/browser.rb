require 'json'

class WaitUntilTimeout < StandardError; end

def wait_until(&block)
  max_time_to_try_until = 5 # in seconds
  time_between_intervals = 0.1 # in seconds

  time_left = max_time_to_try_until
  loop do
    raise WaitUntilTimeout if time_left <= 0
    break if yield
    sleep(time_between_intervals)
    time_left -= time_between_intervals
  end

  true
end

def browser_has_request_with_url_containing(sought)
  wait_until do
    browser_has_request_containing do |url, _post_data|
      url.include?(sought)
    end
  end
end

def browser_has_analytics_request_containing(sought)
  wait_until do
    browser_has_request_containing do |url, post_data|
      url.start_with?("https://www.google-analytics.com") &&
        (url.include?(sought) || post_data.include?(sought))
    end
  end
end

def browser_has_request_containing
  # Most logs look like this:
  #
  # #<Selenium::WebDriver::LogEntry:0x000000012b5d7ba0
  #   @level="INFO",
  #   @timestamp=1651152274458,
  #   @message="{\"message\":{...}}"
  # >
  #
  # Some log messages are just plain strings, such as SEVERE
  # error logs. These should appear in the main "browser" logs
  # so we can safely ignore them here, where we only care about
  # the requests that were sent.
  logs = performance_logs.map do |log|
    JSON.load(log.message)['message']
  rescue JSON::ParserError
    {}
  end

  # The "messages" we're interested in look like this:
  #
  # {
  #   "method"=>"Network.requestWillBeSent",
  #   "params"=>{
  #     "documentURL"=>"https://www.gov.uk/search/all?keywords=tax&order=relevance",
  #     ...
  #     "request"=>{
  #       "headers"=>{...},
  #       ...
  #       "postData"=>"..."  <=== depending on the request
  #       "method"=>"POST",
  #       "url"=>"https://www.google-analytics.com/j/collect?v=1...",
  #     },
  #     "type"=>"XHR",
  #     ...
  #   }
  # }
  #
  # See https://chromedevtools.github.io/devtools-protocol/tot/Network/#event-requestWillBeSent
  logs.any? do |log|
    post_data = log.dig("params", "request", "postData") || ""

    log["method"] == "Network.requestWillBeSent" &&
      yield(log["params"]["request"]["url"], post_data)
  end
end

def performance_logs
  @performance_logs ||= []
  @performance_logs += flush_chrome_logs_for_type(:performance)
  @performance_logs
end

def browser_logs
  @browser_logs ||= []
  @browser_logs += flush_chrome_logs_for_type(:browser)
  @browser_logs
end

def flush_chrome_logs
  # Clear out any unseen logs
  flush_chrome_logs_for_type(:performance)
  flush_chrome_logs_for_type(:browser)

  # Clear out any existing logs
  @performance_logs = []
  @browser_logs = []
end

def flush_chrome_logs_for_type(type)
  # Calling ".get" retrieves and then wipes the logs so far.
  Capybara.current_session.driver.browser.logs.get(type)
end

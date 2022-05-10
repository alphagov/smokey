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
  @logs ||= []

  # Calling ".get" retrieves and then wipes the logs so far, so we
  # need to cache them in case this method is called multiple times,
  # where there may also be more logs available.
  #
  # Each log looks like this:
  #
  # #<Selenium::WebDriver::LogEntry:0x000000012b5d7ba0
  #   @level="INFO",
  #   @timestamp=1651152274458,
  #   @message="{\"message\":{...}}"
  # >
  #
  # This is the same technique used by the Capybara Log Collector,
  # but that does a ".get(:browser)", which isn't affected by the
  # call we're making here.
  #
  # https://github.com/dbalatero/capybara-chromedriver-logger/blob/e972c9865ac1955529649566704d5878205f909c/lib/capybara/chromedriver/logger/collector.rb#L49
  @logs += Capybara.current_session.driver
    .browser.manage.logs.get(:performance)
    .map { |log| JSON.load(log.message)['message'] }

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
  @logs.any? do |log|
    post_data = log.dig("params", "request", "postData") || ""

    log["method"] == "Network.requestWillBeSent" &&
      yield(log["params"]["request"]["url"], post_data)
  end
end

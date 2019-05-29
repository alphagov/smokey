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
end

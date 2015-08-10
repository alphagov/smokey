require 'logger'

def activate_capybara_mechanize_request_tracing!(logger = Logger.new(STDOUT))
  Capybara::Mechanize::Browser.instance_eval do
    old_process_remote_request = instance_method(:process_remote_request)

    define_method(:process_remote_request) do |method, url, attributes, headers|
      logger.info "#{method.upcase} #{url}"
      old_process_remote_request.bind(self).(method, url, attributes, headers)
    end
  end
end

# Uncomment this line if you want to see log output for every HTTP request
# made through mechanize:
#
# activate_capybara_mechanize_request_tracing!

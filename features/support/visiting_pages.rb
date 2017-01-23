require 'base64'

def visit_path(path)
  if ENV['AUTH_USERNAME'] && ENV['AUTH_PASSWORD']
    auth_string = Base64.encode64("#{ENV['AUTH_USERNAME']}:#{ENV['AUTH_PASSWORD']}").strip
    page.driver.header "Authorization", "Basic #{auth_string}"
  end

  if path.match(%r[\?])
    visit "#{path}&cachebust=#{rand.to_s}"
  else
    visit "#{path}?cachebust=#{rand.to_s}"
  end

  page.driver.error_messages.should == []
end

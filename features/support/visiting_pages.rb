require 'base64'

def visit_path(path)
  if ENV['AUTH_USERNAME'] && ENV['AUTH_PASSWORD']
    page.driver.basic_authorize(ENV['AUTH_USERNAME'], ENV['AUTH_PASSWORD'])
  end

  if path.match(%r[\?])
    visit "#{path}&cachebust=#{rand.to_s}"
  else
    visit "#{path}?cachebust=#{rand.to_s}"
  end
end

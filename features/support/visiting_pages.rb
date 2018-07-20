require 'base64'

def visit_path(path)
  if path.match(%r[\?])
    visit "#{path}&cachebust=#{rand.to_s}"
  else
    visit "#{path}?cachebust=#{rand.to_s}"
  end
end

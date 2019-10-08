require 'base64'

def visit_path(path)
  if path.match(%r[\?])
    visit "#{path}&smokey_cachebust=#{rand.to_s}"
  else
    visit "#{path}?smokey_cachebust=#{rand.to_s}"
  end
end

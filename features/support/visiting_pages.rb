require 'base64'

def visit_path(path)
  url_param_joiner = path.match(%r[\?]) ? "&" : "?"
  visit "#{path}#{url_param_joiner}smokey_cachebust=#{rand.to_s}"
end

def govuk_page
  page
end

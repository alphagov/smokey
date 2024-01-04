require 'base64'

def visit_path(path)
  if path.match(%r[\?])
    visit "#{path}&smokey_cachebust=#{rand.to_s}"
  else
    visit "#{path}?smokey_cachebust=#{rand.to_s}"
  end
end

def wait_for_any_redirects_to_govuk
  page.has_css?(".govuk-template")
end

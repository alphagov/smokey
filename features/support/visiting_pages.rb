require 'base64'

def visit_path(path)
  if path.match(%r[\?])
    visit "#{path}&smokey_cachebust=#{rand.to_s}"
  else
    visit "#{path}?smokey_cachebust=#{rand.to_s}"
  end
end

# When an assertion is made against a page that has been redirected
# to, Cucumber won't wait for the redirect to finish first. We can
# use Capybara's `.has_css?` method, which waits until an element
# matching the selector is found. `govuk-template` is the class name
# on the `<html>` element for all GOV.UK HTML pages, so should
# reliably indicate that the redirect has completed.
def wait_for_any_redirects_to_govuk
  page.has_css?(".govuk-template")
end

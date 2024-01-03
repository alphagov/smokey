require 'base64'

def visit_path(path)
  url_param_joiner = path.match(%r[\?]) ? "&" : "?"
  visit "#{path}#{url_param_joiner}smokey_cachebust=#{rand.to_s}"
end

class GovukPage
  def initialize(page, response)
    @page = page
    @response = response
  end

  def body
    return @response.body if @response

    @page.body
  end

  def status_code
    return @response.code.to_i if @response

    @page.status_code.to_i
  end

  def current_path
    # TODO: support `@response` version
    @page.current_path
  end

  def current_url
    # TODO: support `@response` version
    @page.current_url
  end

  def has_content?(content)
    # TODO: support `@response` version
    @page.has_content?(content)
  end

  def all(selector)
    # TODO: support `@response` version
    @page.all(selector)
  end

  def find(selector, **options)
    # TODO: support `@response` version
    @page.find(selector, **options)
  end

  def execute_script(script_contents)
    # TODO: support `@response` version
    @page.execute_script(script_contents)
  end
end

def govuk_page
  GovukPage.new(page, @response)
end

require 'net/http'
require 'rest_client'
require 'cgi'

def head_request(url, options = {})
  do_http_request(url, :head, options)
end

def get_request(url, options = {})
  do_http_request(url, :get, options)
end

def try_get_request(url, options = {})
  # Always return the response, even if it's an error code
  do_http_request(url, :get, options) { |response, request, result|
    response
  }
end

def uri_escape(s)
  CGI.escape(s)
end

def default_request_options
  { auth: @authenticated, cache_bust: @bypass_varnish, search_cache_bust: @bypass_varnish_for_search, client_auth: @authenticated_as_client }
end

# Make a POST.
# Options is expected to contain a :payload key which contains the payload for the POST request.
def post_request(url, options = {})
  do_http_request(url, :post, options) { |response, request, result, &block|

    # This happens for a 303 already - https://github.com/archiloque/rest-client/commit/1b97ddeb74
    if [301, 302, 307].include? response.code

      # Clone the existing request, but change POST to GET a la standard browser behaviour. I know.
      args = request.args

      if args[:method] == :post
        args[:method] = :get
        args.delete :payload
      end

      return response if options[:dont_follow_redirects]

      response.follow_redirection(&block)
    else
      response.return!(&block)
    end
  }
end

def cache_bust(url, param: 'cache_bust')
  cache_bust = "#{param}=#{rand}"
  separator = url.include?("?") ? "&" : "?"
  "#{url}#{separator}#{cache_bust}"
end

def do_http_request(url, method = :get, options = {}, &block)
  defaults = {
    :auth => true,
    :verify_ssl => true,
  }
  options = defaults.merge(options)

  headers = {
    'User-Agent' => 'Smokey Test / Ruby',
    'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'FASTLY-DEBUG' => '1',
  }

  started_at = Time.now

  spoof_target_domain = ENV['SPOOF_TARGET_DOMAIN']
  if spoof_target_domain
    options[:host_header] = URI(url).host
    url = URI(url).scheme + "://" + spoof_target_domain
    # FIXME: this is set only in the interests of the migration period
    options[:verify_ssl] = false
  end
  if options[:cache_bust]
    url = cache_bust(url, param: 'cache_bust')
  elsif options[:search_cache_bust]
    url = cache_bust(url, param: 'c')
  end
  if options[:auth]
    user     = ENV['AUTH_USERNAME']
    password = ENV['AUTH_PASSWORD']
  end
  if options[:client_auth]
    headers["Authorization"] = "Bearer #{ENV['BEARER_TOKEN']}"
    headers["Accept"] = "application/json"
  end
  if options[:host_header]
    headers["Host"] = options[:host_header]
  end
  if options[:cookies]
    headers["Cookie"] = options[:cookies].map { |k, v| "#{k}=#{v}" }.join("; ")
  end
  rate_limit_token = ENV['RATE_LIMIT_TOKEN']
  if rate_limit_token
    headers["Rate-Limit-Token"] = rate_limit_token
  end

  request_options = {
    url: url,
    method: method,
    user: user,
    password: password,
	headers: headers.merge(options[:headers] || {}),
    timeout: 10,
    payload: options[:payload],
    verify_ssl: options[:verify_ssl],
  }
  RestClient::Request.new(request_options).execute &block
rescue RestClient::Unauthorized => e
  raise "Unable to fetch '#{url}' due to '#{e.message}'. Maybe you need to set AUTH_USERNAME and AUTH_PASSWORD?"
rescue RestClient::Exception => e
  if options[:return_response_on_error]
    e.response
  else
    finished_at = Time.now
    message = ["Unable to fetch '#{url}'"]
    message += ["  Exception: '#{e}'"]
    message += ["  Response headers: #{e.response.headers.inspect if e.response}"]
    message += ["  Response time in seconds: #{finished_at - started_at}"]
    raise message.join("\n")
  end
end

def single_http_request(url)
  started_at = Time.now
  uri = URI(url)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = uri.scheme == 'https'
  http.start { |agent| response = agent.get(uri.path) }
end

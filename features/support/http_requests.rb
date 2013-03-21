require 'net/http'
require 'rest_client'

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

def default_request_options
  { auth: @authenticated, cache_bust: @bypass_varnish, client_auth: @authenticated_as_client }
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

      response.follow_redirection(RestClient::Request.new(args), result, &block)
    else
      response.return!(request, result, &block)
    end
  }
end

def cache_bust(url)
  cache_bust = 'cache_bust=' + rand.to_s
  separator = url.include?("?") ? "&" : "?"
  "#{url}#{separator}#{cache_bust}"
end

def do_http_request(url, method = :get, options = {}, &block)
  defaults = {
    :auth => true,
  }
  options = defaults.merge(options)
  headers = {
    'User-Agent' => 'Smokey Test / Ruby',
    'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'X-Forwarded-For' => "10.0.0.#{rand(256)}",
  }

  started_at = Time.now
  url = options[:cache_bust] ? cache_bust(url) : url
  if options[:auth]
    user     = ENV['AUTH_USERNAME']
    password = ENV['AUTH_PASSWORD']
  end
  if options[:client_auth]
    headers["Authorization"] = "Bearer #{ENV['BEARER_TOKEN']}"
    headers["Accept"] = "application/json"
  end

  RestClient::Request.new(
    url: url,
    method: method,
    user: user,
    password: password,
    headers: headers,
    payload: options[:payload]
  ).execute &block
rescue RestClient::Unauthorized => e
  raise "Unable to fetch '#{url}' due to '#{e.message}'. Maybe you need to set AUTH_USERNAME and AUTH_PASSWORD?"
rescue RestClient::Exception => e
  finished_at = Time.now
  message = ["Unable to fetch '#{url}'"]
  message += ["  Exception: '#{e}'"]
  message += ["  Response headers: #{e.response.headers.inspect if e.response}"]
  message += ["  Response time in seconds: #{finished_at - started_at}"]
  raise message.join("\n")
end

def single_http_request(url)
  started_at = Time.now
  uri = URI(url)
  Net::HTTP::get_response(uri)
end

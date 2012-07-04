require 'net/http'
require 'rest_client'

def head_request(url, options = {})
  do_http_request(url, :head, options)
end

def get_request(url, options = {})
  do_http_request(url, :get, options)
end

def cache_bust(url)
  cache_bust = 'cache_bust=' + rand.to_s
  separator = url.include?("?") ? "&" : "?"
  "#{url}#{separator}#{cache_bust}"
end

def do_http_request(url, method = :get, options = {})
  started_at = Time.now
  url = options[:cache_bust] ? cache_bust(url) : url
  RestClient::Request.new(
    url: url,
    method: method,
    user: ENV['AUTH_USERNAME'],
    password: ENV['AUTH_PASSWORD'],
    headers: {
      'User-Agent' => 'Smokey Test / Ruby',
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    }
  ).execute
rescue RestClient::Unauthorized => e
  raise "Unable to fetch '#{url}' due to '#{e.message}'. Maybe you need to set AUTH_USERNAME and AUTH_PASSWORD?"
rescue RestClient::Exception => e
  finished_at = Time.now
  message = ["Unable to fetch '#{url}'"]
  message += ["  Exception: '#{e}'"]
  message += ["  Response headers: #{e.response.headers.inspect}"]
  message += ["  Response time in seconds: #{finished_at - started_at}"]
  raise message.join("\n")
end

def target_platform
  ENV["TARGET_PLATFORM"] || "preview"
end

def base_url
  if target_platform == "production"
    "https://www.gov.uk"
  else
    "https://www.#{target_platform}.alphagov.co.uk"
  end
end

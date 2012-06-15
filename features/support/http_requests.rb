require 'net/http'
require 'rest_client'

def head_request(url)
  do_http_request(url, :head)
end

def get_request(url)
  do_http_request(url, :get)
end

def do_http_request(url, method = :get)
  RestClient::Request.new(
    url: url,
    method: method, 
    user: ENV['AUTH_USERNAME'], 
    password: ENV['AUTH_PASSWORD']
  ).execute
rescue RestClient::Unauthorized => e
  raise "Unable to fetch '#{url}' due to '#{e.message}'. Maybe you need to set AUTH_USERNAME and AUTH_PASSWORD?"
rescue RestClient::Exception => e
  raise "Unable to fetch '#{url}' due to '#{e}'"
end  
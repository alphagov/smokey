require 'uri'
require 'ostruct'

class Response
  attr_reader :header_lines

  def initialize(raw_curl_output)
    @header_lines = raw_curl_output.split(/\r?\n/)
  end

  def successful?
    (200..299).cover?(code)
  end

  def code
    matches = header_lines.first && header_lines.first.match(/HTTP\/[^ ]+ ([0-9]+) (.*)$/)
    matches && matches[1].to_i
  end
end

def fetch_url_with_dns_override(url_string, ip)
  url = URI(url_string)

  rate_limiting_busting_headers = %Q('X-Forwarded-For: 10.0.0.#{rand(256)}')

  output_only_headers = "-I"
  authentication = if ENV['AUTH_USERNAME'] && ENV['AUTH_PASSWORD']
    "-u '#{ENV['AUTH_USERNAME']}:#{ENV['AUTH_PASSWORD']}'"
  end
  dns_resolution_override = "--resolve #{url.host}:#{url.port}:#{ip}"
  cmd = "curl --silent --connect-timeout 5 --max-time 5 #{rate_limiting_busting_headers} #{output_only_headers} #{authentication} #{dns_resolution_override} #{url.to_s}"
  puts cmd
  Response.new(`#{cmd}`)
end

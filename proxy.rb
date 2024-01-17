require "cgi"
require "webrick"
require "net/http"
require_relative "./features/support/env_vars.rb"

PROFILES = {
  debug: {
    host: "headers.4tools.net",
    headers: {
      "User-Agent": "Smokey Test / Ruby",
    },
  },
  mirrorS3: {
    host: "www.gov.uk",
    headers: {
      "User-Agent": "Smokey Test / Ruby",
      "Backend-Override": "mirrorS3",
    },
    spoofAssets: true,
  },
  mirrorS3Replica: {
    host: "www.gov.uk",
    headers: {
      "User-Agent": "Smokey Test / Ruby",
      "Backend-Override": "mirrorS3",
    },
    spoofAssets: true,
  },
  mirrorGCS: {
    host: "www.gov.uk",
    headers: {
      "User-Agent": "Smokey Test / Ruby",
      "Backend-Override": "mirrorS3",
    },
    spoofAssets: true,
  },
  failoverCDN: {
    host: ENV["GOVUK_WEBSITE_HOST"],
    headers: {
      "User-Agent": "Smokey Test / Ruby",
      "Host": "www.gov.uk",
    },
  },
  primaryCDN: {
    host: ENV["GOVUK_WEBSITE_HOST"],
    headers: {
      "User-Agent": "Smokey Test / Ruby",
    },
  }
}

PROFILE = ENV.has_key?("PROXY_PROFILE") ? PROFILES[ENV["PROXY_PROFILE"].to_sym] : nil
raise "PROXY_PROFILE ENV var needs to be one of #{PROFILES.keys.join(', ')}" if PROFILE.nil?

class MyProxy < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    make_http_request(request, response) do |uri|
      Net::HTTP::Get.new(uri)
    end
  end

  def do_POST(request, response)
    make_http_request(request, response) do |uri|
      req = Net::HTTP::Post.new(uri)
      req.set_form_data(CGI::parse(request.body))
      req
    end
  end

  def make_http_request(request, response)
    if PROFILE[:spoofAssets] && (request.path.match?(/.svg$/) || request.path.match?(/.ico$/) || request.path.match?(/.js$/))
      # Some assets presumably haven't been copied to the mirror?
      # If we don't stub this response, we return a 503.
      response.status = 200
    else
      uri = URI.parse("https://#{PROFILE[:host]}#{request.path}")
      uri.query = request.query_string
      req = yield(uri)
      PROFILE[:headers].each do |header_name, header_value|
        req[header_name] = header_value
      end
      req_options = {
        use_ssl: uri.scheme == "https",
      }

      resp = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(req)
      end

      response.status = resp.code
      response.content_type = resp["content-type"]
      response.body = resp.body

      case resp
      when Net::HTTPRedirection
        response["Location"] = URI.parse(resp["location"])
      end
    end
  end
end

server = WEBrick::HTTPServer.new(:Port => ENV["PORT"] || 8080)
server.mount "/", MyProxy

trap("INT"){ server.shutdown }
server.start

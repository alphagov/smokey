require "cgi"
require "webrick"
require "net/http"

class GovukProxy < WEBrick::HTTPServlet::AbstractServlet
  def initialize(server, profile)
    super server
    @profile = profile
  end

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
    if @profile[:spoofAssets] && (request.path.match?(/.svg$/) || request.path.match?(/.ico$/) || request.path.match?(/.js$/))
      # Some assets presumably haven't been copied to the mirror?
      # If we don't stub this response, we return a 503.
      response.status = 200
    else
      uri = URI.parse("https://#{@profile[:host]}#{request.path}")
      uri.query = request.query_string
      req = yield(uri)
      @profile[:headers].each do |header_name, header_value|
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

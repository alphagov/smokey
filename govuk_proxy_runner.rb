require "webrick"
require_relative "./features/support/govuk_proxy"
require_relative "./features/support/govuk_proxy_profiles"

profile = GovukProxyProfiles.validate_profile!
server = WEBrick::HTTPServer.new(:Port => ENV["PORT"] || 8080)
server.mount "/", GovukProxy, profile

trap("INT"){ server.shutdown }
server.start

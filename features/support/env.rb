require 'nokogiri'

def target_platform
  ENV["TARGET_PLATFORM"] || "preview"
end

def base_url
  if target_platform == "production"
    "https://www-origin.production.alphagov.co.uk"
  else
    "https://www.#{target_platform}.alphagov.co.uk"
  end
end

module GovukProxyProfiles
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
      host: ENV["FAILOVER_CDN_HOST"],
      headers: {
        "User-Agent": "Smokey Test / Ruby",
        "Host": "www.gov.uk",
      },
    },
    primaryCDN: {
      host: "www.gov.uk",
      headers: {
        "User-Agent": "Smokey Test / Ruby",
      },
    }
  }

  def self.validate_profile!
    profile = ENV.has_key?("GOVUK_PROXY_PROFILE") ? GovukProxyProfiles::PROFILES[ENV["GOVUK_PROXY_PROFILE"].to_sym] : nil
    raise "GOVUK_PROXY_PROFILE ENV var needs to be one of #{GovukProxyProfiles::PROFILES.keys.join(', ')}" if profile.nil?

    profile
  end
end

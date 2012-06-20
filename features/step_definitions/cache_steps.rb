When %r{^I visit some key urls on "([^"]*)"$} do |env_cache|
  server_name = env_cache.gsub("<environment>", ENV['TARGET_PLATFORM'] || "preview")
  ip = server_address(server_name)
  @cache_check_responses ||= []

  urls_paths = %w{/ /government /search /when-do-the-clocks-change /maternity-benefits}
  urls_paths.each do |url_path|
    url = base_url + url_path
    response = fetch_url_with_dns_override(url, ip)
    if !response.successful?
      raise "Failed to fetch '#{url}' from '#{server_name}' (ip #{ip}). " +
        "Response was '#{response.header_lines.first}'." 
    end
    puts "(ip #{ip}) #{url}"
    @cache_check_responses << response
  end
end

Then /^every visit should get a success response$/ do
  all_ok = @cache_check_responses.all? { |response| response.successful? }
  all_ok.should be_true
end

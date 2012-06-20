def server_address(server_name)
  server_addresses = {
    "preview-cache" => "176.34.205.133",
    "preview-cache-1" => "176.34.223.80",
    "preview-cache-2" => "46.137.49.54",
    "production-cache" => "176.34.196.237",
    "production-cache-1" => "46.137.14.226",
    "production-cache-2" => "176.34.171.193"
  }
  server_addresses[server_name] or raise "server #{server_name} not recognised"
end

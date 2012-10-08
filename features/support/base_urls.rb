def efg_base_url
  application_base_url('EFG')
end

def signon_base_url
  application_base_url('signon')
end

def application_base_url(app_name)
  platform = target_platform
  case app_name
  when 'calendars' then "http://calendars.#{platform}.alphagov.co.uk/bank-holidays"
    when 'businesssupportfinder' then "https://businesssupportfinder.#{platform}.alphagov.co.uk/business-finance-support-finder"
  when 'EFG' then "https://efg.#{target_platform}.alphagov.co.uk"
  when 'frontend' then "https://frontend.#{platform}.alphagov.co.uk/"
  when 'licencefinder' then "https://licencefinder.#{platform}.alphagov.co.uk/licence-finder"
  when 'panopticon' then "https://panopticon.#{platform}.alphagov.co.uk/"
  when 'publisher' then "https://publisher.#{platform}.alphagov.co.uk/admin"
  when 'signon' then "https://signon.#{target_platform}.alphagov.co.uk/"
  when 'smartanswers' then "http://smartanswers.#{platform}.alphagov.co.uk/maternity-benefits"
  when 'tariff-backend' then "https://tariff-api.#{platform}.alphagov.co.uk/"
  when 'tariff-frontend' then "https://tariff.#{platform}.alphagov.co.uk/trade-tariff"
  when 'whitehall' then "http://whitehall-frontend.#{platform}.alphagov.co.uk/government"
  else
    raise "Application '#{app_name}' not recognised, unable to boot it up"
  end
end
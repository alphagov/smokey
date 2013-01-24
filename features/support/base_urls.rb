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
  when 'imminence' then "https://imminence.#{platform}.alphagov.co.uk/"
  when 'licencefinder' then "https://licencefinder.#{platform}.alphagov.co.uk/licence-finder"
  when 'licensing' then "https://licensify.#{platform}.alphagov.co.uk/apply-for-a-licence"
  when 'panopticon' then "https://panopticon.#{platform}.alphagov.co.uk/"
  when 'public-contentapi' then "https://www.#{platform}.alphagov.co.uk/api/tags.json" # this should be changed to a Content API 'homepage' when we have one
  when 'publisher' then "https://publisher.#{platform}.alphagov.co.uk/admin"
  when 'signon' then "https://signon.#{target_platform}.alphagov.co.uk/"
  when 'smartanswers' then "http://smartanswers.#{platform}.alphagov.co.uk/maternity-benefits"
  when 'tariff-backend' then "https://tariff-api.#{platform}.alphagov.co.uk/"
  when 'tariff-frontend' then "https://tariff.#{platform}.alphagov.co.uk/trade-tariff"
  when 'whitehall' then "http://whitehall-frontend.#{platform}.alphagov.co.uk/government"
  when 'imminence' then "http://imminence.#{platform}.alphagov.co.uk/admin"
  else
    raise "Application '#{app_name}' not recognised, unable to boot it up"
  end
end

DEFAULT_PATHS = {
  'calendars' => '/bank-holidays',
  'contacts' => '/hm-revenue-customs',
  'imminence' => '/admin',
  'licensefinder' => '/licence-finder',
  'licensify-admin' => '/login',
  'licensing' => '/apply-for-a-license',
  'publisher' => '/admin',
  'smartanswers' => '/calculate-your-maternity-pay',
  'travel-advice-publisher' => '/admin',
  'whitehall' => '/government/how-government-works'
}

def application_external_url(app_name)
  "#{Plek.new.external_url_for(app_name)}#{DEFAULT_PATHS.fetch(app_name,'')}"
end

def application_internal_url(app_name)
  "#{Plek.new.find(app_name)}#{DEFAULT_PATHS.fetch(app_name,'')}"
end

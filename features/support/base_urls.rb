DEFAULT_PATHS = {
  'calendars' => '/bank-holidays',
  'collections-publisher' => '/mainstream-browse-pages',
  'contacts' => '/hm-revenue-customs',
  'contacts-admin' => '/admin',
  'places-manager' => '/admin',
  'licensify-admin' => '/login',
  'licensing' => '/apply-for-a-license',
  'maslow' => '/needs',
  'publisher' => '/admin',
  'smartanswers' => '/calculate-your-maternity-pay',
  'specialist-publisher' => '/cma-cases',
  'travel-advice-publisher' => '/admin',
  'whitehall' => '/government/how-government-works',
  'whitehall-admin' => '/government/admin'
}

def application_external_url(app_name)
  url = "#{Plek.new.external_url_for(app_name)}#{DEFAULT_PATHS.fetch(app_name,'')}"
  log "application_external_url(#{app_name}) = '#{url}'"
  url
end

def application_internal_url(app_name)
  url = "#{Plek.new.find(app_name)}"
  log "application_internal_url(#{app_name}) = '#{url}'"
  url
end

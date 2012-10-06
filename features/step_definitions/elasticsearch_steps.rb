Then /^the status JSON should tell me it's okay$/ do
  assert JSON.parse(@response.body)['ok']
end
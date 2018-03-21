When /^I search for "(.*)" in datasets$/ do |term|
  visit_path "#{@host}/search?q=#{term}"
end

Then /^I should see some dataset results$/ do
  result_links = page.all(".dgu-results__result")
  result_links.count.should >= 1
end

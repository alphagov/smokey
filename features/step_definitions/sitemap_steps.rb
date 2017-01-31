When /^I get the sitemap index$/ do
  step "I visit \"/sitemap.xml\""
  @sitemap_doc = Nokogiri.XML(page.body)
  @sitemap_links = @sitemap_doc.xpath("/xmlns:sitemapindex/xmlns:sitemap/xmlns:loc")
end

Then /^It should contain a link to at least one sitemap file$/ do
  expect(@sitemap_links.size).to be >= 1
end

Then /^I should be able to get all the referenced sitemap files$/ do
  @sitemap_links.each do |link|
    # doing a HEAD request because the referenced files are fairly large.
    head_request(link.text, default_request_options)
  end
end

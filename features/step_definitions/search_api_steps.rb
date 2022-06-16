Then /^it should contain a link to at least one sitemap file$/ do
  # Chrome returns XML inside an HTML wrapper, so this JavaScript snippet
  # extracts the XML (see https://stackoverflow.com/questions/44370831)
  xml_body = page.execute_script('return document.getElementById("webkit-xml-viewer-source-xml").innerHTML')
  @sitemap_doc = Nokogiri.XML(xml_body)
  @sitemap_links = @sitemap_doc.xpath("/xmlns:sitemapindex/xmlns:sitemap/xmlns:loc")
  expect(@sitemap_links.size).to be >= 1
end

Then /^I should be able to get the referenced sitemap files$/ do
  # doing a HEAD request because the referenced files are fairly large.
  head_request(@sitemap_links.first.text, default_request_options)
end

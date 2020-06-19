When "I request the homepage from the Publishing API" do
  homepage_content_id = "f3bbdec2-0e62-4520-a7fd-6ffd5d36e03a"
  @response = GdsApi.publishing_api.get_content(homepage_content_id).to_h
end

When "I request homepage links from the Publishing API" do
  homepage_content_id = "f3bbdec2-0e62-4520-a7fd-6ffd5d36e03a"
  @response = GdsApi.publishing_api.get_expanded_links(homepage_content_id).to_h
end

When "I request organisation linkables from the Publishing API" do
  @response = GdsApi.publishing_api.get_linkables(document_type: "organisation").to_a
end

Then "I receive a payload with the content" do
  expect(@response["title"]).to eq "GOV.UK homepage"
end

Then "I receive a payload with the expanded links" do
  expect(@response["expanded_links"].keys).to include "primary_publishing_organisation"
  expect(@response["expanded_links"]["primary_publishing_organisation"].first).to be_a Hash
end

Then "I receive a payload with all the organisations" do
  expect(@response.first.keys).to include("content_id", "title", "base_path")
end

module Status
  OK = 200
  NOT_FOUND = 404
  GONE = 410
end

When "I go to add an artefact" do
  click_on "Add artefact"
  expect(page).to have_content("New artefact")
end

When "I create a draft place" do
  fill_in "Title", with: publication_title
  fill_in "Slug", with: parameterize(publication_title)
  select "Place", from: "Format"
  click_button "Save and go to item"
end

When "I preview the draft place" do
  click_on "Preview"

  wait_until do
    status = get_status_code do
      visit page.current_url
    end

    status != Status::NOT_FOUND
  end
end

When "I should see that the content has been published" do
  expect(page).to have_content(publication_title)
  expect(page.current_path).to eq(publication_path)
  expect(page).to_not have_content("GOV.UK Publisher")
end

When /I search for the content in category "([^"]*)"/ do |status|
  select "Nobody", from: "Assignee"
  fill_in "Keyword", with: publication_title
  select "Place", from: "Format"
  click_button "Filter publications"
  click_link status
end

When "I go to the content from the search results" do
  click_link publication_title
end

When "I request 2nd pair of eyes" do
  click_on "2nd pair of eyes"
  click_on "Send to 2nd pair of eyes"
end

When "I skip the review" do
  click_on "Skip review"

  within "#skip_review_form" do
    click_on "Skip review"
  end

  wait_until { find('span[title="Status"]').text == "Ready" }
end

When "I publish the draft" do
  click_on "Publish"
  click_on "Send to publish"
end

When "I view the published content on live" do
  click_on "View this on the GOV.UK website"

  wait_until do
    status = get_status_code do
      visit_path publication_url
    end

    status != Status::NOT_FOUND
  end
end

When /I go to the "([^"]*)" section/ do |section|
  click_link section
end

When "I unpublish the edition" do
  accept_alert do
    click_button "Unpublish"
  end
end

When "I should see that the content has been unpublished" do
  expect(page).to have_content("Content unpublished")

  wait_until do
    status = get_status_code do
      visit_path publication_url
    end

    status == Status::GONE
  end
end

def parameterize(str)
  str.downcase.gsub(/\s/,'-')
end

def publication_title
  @publication_title ||= "Smokey test draft place #{$smokey_run_id}"
end

def publication_path
  @publication_path ||= "/#{parameterize(publication_title)}"
end

def publication_url
  @publication_url ||= "#{ENV['GOVUK_WEBSITE_ROOT']}#{publication_path}"
end

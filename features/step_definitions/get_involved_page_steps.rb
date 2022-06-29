And /^it should be populated with three open consultations$/ do
  within ".get-involved > div:nth-child(4) > div" do
    expect(page).to have_css(".gem-c-document-list__item-title", count: 3)
  end
end

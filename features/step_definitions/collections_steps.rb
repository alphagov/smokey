When(/^I toggle the first accordion section$/) do
  first('.js-subsection-title-link').click
end

Then(/^I can see an accordion$/) do
  page.should have_css('.js-accordion-with-descriptions')
end

Then(/^I cannot see any of the accordion content$/) do
  page.should_not have_css('.subsection-content')
end

Then(/^I can(not)? see the accordion content for only the first item$/) do |cannot|
  should_see_accordion = cannot.nil?

  all('.js-subsection').each_with_index do |subsection, index|
    if index == 0 && should_see_accordion
      subsection.should have_css('.subsection-content')
    else
      subsection.should_not have_css('.subsection-content')
    end
  end
end

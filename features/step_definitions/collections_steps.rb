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

Then(/^I am in the "(.*?)" variant of the education navigation test$/) do |variant|
  ab_cookie = page.driver.cookies["ABTest-EducationNavigation"]

  assert_equal(
    variant,
    ab_cookie.value,
    "We have been assigned to the incorrect variant"
  )

  assert(
    ab_cookie.expires,
    "Expected the cookie to have an expiry date"
  )
end

Then(/^I stay on bucket "(A|B)" of the education navigation test when I keep visiting "(.*?)"$/) do |variant, path|
  20.times do
    response = visit path
    education_ab_cookie = page.driver.cookies['ABTest-EducationNavigation']

    assert_equal(
      variant,
      education_ab_cookie.value,
      "The ABTest-EducationNavigation cookie value doesn't match"
    )
  end
end

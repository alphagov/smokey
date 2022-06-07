@app-collections @replatforming
Feature: Collections

  Background:
    Given I force a varnish cache miss

  # TODO: RENAME to clarify this is testing data transfer
  # with Content Store (as the prime example for the app).
  #
  Scenario: Check mainstream browse page loads with links
    When I visit "/browse/driving"
    And I should see "Teaching people to drive"
    When I click on the section "Teaching people to drive"
    Then I should see "Apply to become a driving instructor"

  # TODO: RENAME to clarify this is testing data transfer with
  # Search API.
  #
  Scenario: Check services and information page loads correctly
    When I visit "/government/organisations/hm-revenue-customs/services-information"
    Then I see links to pages per topic

  # TODO: RENAME to clarify this is testing data transfer with
  # Email Alert API (as the prime example for the app).
  #
  # Note: this scenario also covers legacy functionality in Email
  # Alert Frontend [^1]. It's easier to make it the prime example
  # than try to justify its removal.
  #
  # [^1]: https://github.com/alphagov/email-alert-frontend/tree/ffaba3f435bcddc8489ac8e3666008dd64ffddf4#signup
  #
  Scenario: Email signup from a taxon page
    When I visit "/education"
    Then I should see "Get emails for this topic"
    When I click on the link "Get emails for this topic"
    Then I should see "What do you want to get emails about?"
    When I choose radio button "Teaching and leadership" and click on "Continue"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

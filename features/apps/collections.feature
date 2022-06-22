@app-collections @replatforming
Feature: Collections

  Scenario: Check the frontend can talk to Content Store
    When I visit "/browse/driving"
    And I should see "Teaching people to drive"
    And I click on the section "Teaching people to drive"
    Then I should see "Apply to become a driving instructor"

  Scenario: Check the frontend can talk to Search API
    When I visit "/government/organisations/hm-revenue-customs/services-information"
    Then I see links to pages per topic

  Scenario: Check the frontend can talk to Email Alert API
    When I visit "/education"
    Then I should see "Get emails for this topic"
    When I click on the link "Get emails for this topic"
    Then I should see "What do you want to get emails about?"
    When I choose radio button "Teaching and leadership" and click on "Continue"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not tested in app)
  #
  # Should be tested in Collections, if at all, when the app takes
  # over from Static and renders its own layout [^1].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/976#discussion_r903528402
  #
  Scenario: Check the feedback component loads
    When I visit "/government/organisations"
    And I confirm it is rendered by "collections"
    And I can operate the feedback component

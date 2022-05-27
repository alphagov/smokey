@replatforming
Feature: Foreign Travel Advice

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Check the index page loads correctly
    When I visit "/foreign-travel-advice"
    Then I should see "Foreign travel advice"
    And I should see "Afghanistan"
    And I should see "Luxembourg"

  Scenario: Check a country page loads correctly
    When I visit "/foreign-travel-advice/luxembourg"
    Then I should see "Luxembourg"
    And I should see "Summary"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not a critical feature)
  #
  # Data transfer with Content Store is already covered by e.g.
  # "Check the index page loads correctly".
  #
  # Also tested in app [^1][^2].
  #
  # [^1]: https://github.com/alphagov/frontend/blob/d98da1aa0f62eb12b57af37f45bd9d728d1097ba/test/integration/travel_advice_atom_test.rb
  # [^2]: https://github.com/alphagov/government-frontend/blob/fe38c9405ade2f53abc076da70a50eccd7cc08fe/test/integration/travel_advice_atom_feed_test.rb
  #
  Scenario: Check feeds are available for both index and countries
    Then I should be able to visit:
      | Path                                   |
      | /foreign-travel-advice.atom            |
      | /foreign-travel-advice/luxembourg.atom |

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (edge case)
  #
  # Data transfer with Content Store is already covered by e.g.
  # "Check the index page loads correctly".
  #
  # Also tested in app [^1][^2].
  #
  # [^1]: https://github.com/alphagov/government-frontend/blob/fe38c9405ade2f53abc076da70a50eccd7cc08fe/test/integration/travel_advice_atom_feed_test.rb#L21
  # [^2]: https://github.com/alphagov/government-frontend/blob/fe38c9405ade2f53abc076da70a50eccd7cc08fe/test/presenters/content_item_presenter_test.rb#L29
  #
  Scenario: Check country feed contains the correct website root
    When I visit "/foreign-travel-advice/ireland.atom"
    Then the XML ID is formed from the correct URL

  Scenario: Email signup from foreign travel advice
    When I visit "/foreign-travel-advice/turkey"
    And I click on the link "Get email alerts"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

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

  Scenario: Check feeds are available for both index and countries
    Then I should be able to visit:
      | Path                                   |
      | /foreign-travel-advice.atom            |
      | /foreign-travel-advice/luxembourg.atom |

  Scenario: Check country feed contains the correct website root
    When I visit "/foreign-travel-advice/ireland.atom"
    Then the XML ID is formed from the correct URL

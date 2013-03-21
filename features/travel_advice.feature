Feature: Travel Advice

  Background:
    Given the "frontend" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: check index loads
    When I visit "/foreign-travel-advice"
    Then I should see "Foreign travel advice"
    And I should see "Afghanistan"
    And I should see "Luxembourg"

  @normal
  Scenario: check a country page loads
    When I visit "/foreign-travel-advice/luxembourg"
    Then I should see "Luxembourg"
    And I should see "Current travel advice"

  @normal
  Scenario: Feeds should be available for index and countries
    Then I should be able to visit:
      | Path                                   |
      | /foreign-travel-advice.atom            |
      | /foreign-travel-advice/luxembourg.atom |

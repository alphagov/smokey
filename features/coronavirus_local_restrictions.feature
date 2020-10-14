@app-collections
Feature: Collections

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Postcode checker shows results
    When I visit the postcode checker
    And I enter a valid postcode
    Then I should see the local restrictions results page

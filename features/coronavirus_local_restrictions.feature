@app-collections
Feature: Collections

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Postcode checker shows results
    When I visit the postcode checker
    Then I should be redirected to the national restrictions page

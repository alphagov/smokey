Feature: Government Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario:
    When I visit "/government/case-studies/libraries-unlimited"
    Then I should see "Case study"

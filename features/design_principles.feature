Feature: Design Principles

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: check Design Principles
    When I visit "/design-principles"
    Then I should get a 301 status code
    And I should be at a location path of "/guidance/government-design-principles"

  @normal
  Scenario: check Transformation dashboard
    When I visit "/transformation"
    Then I should get a 301 status code
    And I should be at a location path of "/government/publications/gds-transformation-programme-2013-to-2015"

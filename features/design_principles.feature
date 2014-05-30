Feature: Design Principles

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: check Design Principles
    When I visit "/design-principles"
    Then I should get a 200 status code
    And I should see "Start with needs"

  @normal
  Scenario: check Style Guide
    When I visit "/design-principles/style-guide"
    Then I should get a 200 status code
    And I should see "Content style guide"

  @normal
  Scenario: check Service Manual
    When I visit "/service-manual"
    Then I should get a 200 status code
    And I should see "Government Service Design Manual"

  @normal
  Scenario: check Service Manual search
    When I visit "/service-manual/search?q=alpha"
    Then I should get a 200 status code
    And I should see "alpha"
    And I should see some search results

  @normal
  Scenario: check Transformation dashboard
    When I visit "/transformation"
    Then I should get a 200 status code
    And I should see "Digital Transformation"

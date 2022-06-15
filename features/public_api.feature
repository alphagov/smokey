@replatforming
Feature: Public API

  Background:
    Given I am testing through the full stack

  Scenario: Check the content store returns data
    Given I force a varnish cache miss
    When I request "/api/content/help"
    Then I should get a 200 status code
    And JSON is returned

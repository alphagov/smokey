@replatforming
Feature: Public API

  Scenario: Check the content store returns data
    When I request "/api/content/help"
    Then I should get a 200 status code
    And JSON is returned

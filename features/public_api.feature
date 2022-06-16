@replatforming
Feature: Public API

  Scenario: Check the app is routable (for Content Store)
    When I request "/api/content/help"
    Then I should get a 200 status code
    And JSON is returned

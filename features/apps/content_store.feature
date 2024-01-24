@app-content-store
Feature: Content Store
  Scenario: Check the app is routable
    When I request "/api/content/help"
    Then I should get a 200 status code
    And JSON is returned

@app-local-links-manager
Feature: Local Links Manager
  @app-publishing-api
  Scenario: Can log in to local-links-manager
    When I go to the "local-links-manager" landing page
    And I try to login as a user
    And I go to the "local-links-manager" landing page
    Then I should see "Local Links Manager"
    And I should see "Council"

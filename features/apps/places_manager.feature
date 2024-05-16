@app-places-manager
Feature: Places Manager
  @app-publishing-api
  Scenario: Can log in to places-manager
    When I go to the "places-manager" landing page
    And I try to login as a user
    And I go to the "places-manager" landing page
    Then I should see "All services"

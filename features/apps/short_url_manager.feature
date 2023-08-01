@app-short-url-manager
Feature: Short URL Manager
  @app-publishing-api
  Scenario: Can log in to short-url-manager
    When I go to the "short-url-manager" landing page
    And I try to login as a user
    And I go to the "short-url-manager" landing page
    Then I should see "Short URL"
    And I should see "Request a new"

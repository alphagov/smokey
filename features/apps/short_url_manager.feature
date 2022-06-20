@app-short-url-manager
Feature: Short URL Manager
  @app-publishing-api
  Scenario: Can log in to short-url-manager
    When I go to the "short-url-manager" landing page
    And I try to login as a user
    And I go to the "short-url-manager" landing page
    Then I should see "Short URL manager"
    And I should see "Sign out"
    And I should see "Dashboard"
    And I should see "Request a new URL redirect or short URL"

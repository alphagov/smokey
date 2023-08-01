@app-content-publisher
Feature: Content Publisher
  @app-publishing-api
  Scenario: Can log in to content-publisher
    When I go to the "content-publisher" landing page
    And I try to login as a user
    And I go to the "content-publisher" landing page
    Then I should see "Content Publisher"
    And I should see "Documents"

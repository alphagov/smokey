@app-collections-publisher
Feature: Collections Publisher
  @app-publishing-api
  Scenario: Can log in to collections-publisher
    When I go to the "collections-publisher" landing page
    And I try to login as a user
    And I go to the "collections-publisher" landing page
    Then I should see "Collections Publisher"
    And I should see "Add a mainstream browse page"

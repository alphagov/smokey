@app-manuals-publisher
Feature: Manuals Publisher
  @app-publishing-api
  Scenario: Can log in to manuals-publisher
    When I go to the "manuals-publisher" landing page
    And I try to login as a user
    And I go to the "manuals-publisher" landing page
    Then I should see "Manuals Publisher"
    And I should see "Sign out"
    And I should see "Your manuals"
    And I should see "New manual"


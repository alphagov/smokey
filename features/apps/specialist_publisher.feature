@app-specialist-publisher
Feature: Specialist Publisher
  @app-publishing-api
  Scenario: Can log in to specialist-publisher
    When I go to the "specialist-publisher" landing page
    And I try to login as a user
    And I go to the "specialist-publisher" landing page
    Then I should see "Specialist Publisher"
    And I should see "Add another"

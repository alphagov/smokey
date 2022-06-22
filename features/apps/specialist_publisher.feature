@app-specialist-publisher
Feature: Specialist Publisher
  @app-publishing-api
  Scenario: Can log in to specialist-publisher
    When I go to the "specialist-publisher" landing page
    And I try to login as a user
    And I go to the "specialist-publisher" landing page
    Then I should see "GOV.UK Specialist Publisher"
    And I should see "Sign out"
    And I should see "CMA Cases"
    And I should see "Add another CMA Case"

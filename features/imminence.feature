@app-imminence
Feature: Imminence
  @app-publishing-api
  Scenario: Can log in to imminence
    When I go to the "imminence" landing page
    And I try to login as a user
    And I go to the "imminence" landing page
    Then I should see "GOV.UK Imminence"
    And I should see "Sign out"
    And I should see "All services"

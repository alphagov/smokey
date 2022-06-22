@app-maslow
Feature: Maslow
  @app-publishing-api
  Scenario: Can log in to maslow
    When I go to the "maslow" landing page
    And I try to login as a user
    And I go to the "maslow" landing page
    Then I should see "GOV.UK Maslow"
    And I should see "Sign out"
    And I should see "All needs"

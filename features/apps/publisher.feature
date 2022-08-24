@app-publisher @replatforming
Feature: Publisher
  @app-publishing-api @notreplatforming
  Scenario: Can log in to publisher
    When I go to the "publisher" landing page
    And I try to login as a user
    And I go to the "publisher" landing page
    Then I should see "GOV.UK Publisher"
    And I should see "Sign out"
    And I should see Publisher's publication index

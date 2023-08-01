@app-travel-advice-publisher
Feature: Travel Advice Publisher
  @app-publishing-api
  Scenario: Can log in to travel-advice-publisher
    When I go to the "travel-advice-publisher" landing page
    And I try to login as a user
    And I go to the "travel-advice-publisher" landing page
    Then I should see "Travel Advice Publisher"
    And I should see "All countries"

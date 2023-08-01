@app-service-manual-publisher
Feature: Service Manual Publisher
  @app-publishing-api
  Scenario: Can log in to service-manual-publisher
    When I go to the "service-manual-publisher" landing page
    And I try to login as a user
    And I go to the "service-manual-publisher" landing page
    Then I should see "Service Manual Publisher"
    And I should see "Create a Guide"

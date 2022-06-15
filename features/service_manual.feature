@replatforming @app-service-manual-frontend
Feature: Service Manual

  Scenario: Check the frontend can talk to Content Store
    When I visit "/service-manual"
    Then I should see "Service Manual"

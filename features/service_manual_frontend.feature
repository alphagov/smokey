@replatforming @app-service-manual-frontend
Feature: Service Manual Frontend

  Scenario: Check the frontend can talk to Content Store
    When I visit "/service-manual"
    Then I should see "Service Manual"

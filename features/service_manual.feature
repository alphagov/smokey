@replatforming @app-service-manual-frontend
Feature: Service Manual

  Scenario: Check Service Manual loads correctly
    When I visit "/service-manual"
    Then I should see "Service Manual"

@replatforming @app-service-manual-frontend
Feature: Service Manual

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Check Service Manual loads correctly
    When I visit "/service-manual"
    Then I should see "Service Manual"

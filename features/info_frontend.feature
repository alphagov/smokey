@app-info-frontend
Feature: Info Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Check the info page for the benefits mainstream browse page
    When I visit "/info/browse/benefits"
    Then I should see "Benefits"

  @local-network
  Scenario: Healthcheck
    Given I am testing "info-frontend" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""

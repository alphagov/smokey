@app-publishing-api @local-network
Feature: Publishing API
  Scenario: Healthcheck
    Given I am testing publishing-api internally
    When I request "/healthcheck"
    Then I should get a 200 status code

@app-hmrc-manuals-api
Feature: HMRC Manuals API

  @local-network @aws
  Scenario: Healthcheck
    Given I am testing "hmrc-manuals-api" internally
    When I request "/healthcheck"
    Then I should get a 200 status code

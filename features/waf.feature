@aws @local-network
Feature: WAF
  Tests to ensure expected WAF rules are in place

  Background:
    Given I am testing through the full stack

  @high
  Scenario: Check that the X-Always-Block rule is in place
    Given I set header X-Always-Block to true
    When I send a GET request to "/"
    Then the response status should be "403"

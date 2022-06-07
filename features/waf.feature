@local-network
Feature: WAF
  Tests to ensure expected WAF rules are in place

  Background:
    Given I force a varnish cache miss

  Scenario: Check that the X-Always-Block rule is in place
    Given I set header X-Always-Block to true
    When I send a GET request to "/robots.txt"
    Then I should get a 403 status code

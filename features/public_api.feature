Feature: Public API

  Background:
    Given I am testing through the full stack

  Scenario: Check the search API returns data
    Given I force a varnish cache miss for search
    When I request "/api/search.json"
    Then I should get a 200 status code
    And JSON is returned

  Scenario: Check the content store returns data
    Given I force a varnish cache miss
    When I request "/api/content/help"
    Then I should get a 200 status code
    And JSON is returned

  Scenario: Check the collections organisations API returns data
    Given I force a varnish cache miss
    When I request "/api/organisations"
    Then I should get a 200 status code
    And JSON is returned

  Scenario: Check the collections organisation API returns data
    Given I force a varnish cache miss
    When I request "/api/organisations/hm-revenue-customs"
    Then I should get a 200 status code
    And JSON is returned

  Scenario: Check the whitehall governments API returns data
    Given I force a varnish cache miss
    When I request "/api/governments"
    Then I should get a 200 status code
    And JSON is returned

  Scenario: Check the whitehall world locations API returns data
    Given I force a varnish cache miss
    When I request "/api/world-locations"
    Then I should get a 200 status code
    And JSON is returned

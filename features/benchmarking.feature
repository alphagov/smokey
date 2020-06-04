@benchmarking
Feature: Benchmarking
  Tests to check the loading times for various pages on GOV.UK.

  @high @local-network @aws
  Scenario: Check Bouncer application is up
    Given I am testing "bouncer" internally
    And I am benchmarking
    When I request "http://www.attorneygeneral.gov.uk" from Bouncer directly
    Then I should get a 301 status code
    And I should get a "Location" header of "https://www.gov.uk/government/organisations/attorney-generals-office"
    And the elapsed time should be less than 2 seconds

  @low @notintegration @nottraining @aws
  Scenario: Check the licence finder home page loads quickly
    Given I am benchmarking
    And I am testing through the full stack
    When I visit "/licence-finder"
    Then the elapsed time should be less than 2 seconds

  @normal @notintegration @nottraining
  Scenario: Check requesting a PDF takes a reasonable amount of time
    Given I am testing "licensing" internally
      And I am benchmarking
      And I am testing through the full stack
      And I force a varnish cache miss
    When I request "/apply-for-a-licence/forms/bury/test-licence/9999-7-1,0-1"
    Then the elapsed time should be less than 10 seconds

  @normal
  Scenario: Check whitehall-frontend pages load quickly
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/how-government-works"
    Then the elapsed time should be less than 2 seconds

  @normal
  Scenario: Check the whitehall API loads quickly
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/api/world-locations"
    Then the elapsed time should be less than 2 seconds

  @normal @aws
  Scenario: Check the research and statistics page loads quickly
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/search/research-and-statistics"
    Then the elapsed time should be less than 4 seconds

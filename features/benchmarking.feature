Feature: Benchmarking

  @high @benchmarking @local-network
  Scenario: Bouncer application is up
    Given I am testing "bouncer" internally
    And I am benchmarking
    When I request "http://www.attorneygeneral.gov.uk" from Bouncer directly
    Then I should get a 301 status code
    And I should get a "Location" header of "https://www.gov.uk/government/organisations/attorney-generals-office"
    And the elapsed time should be less than 2 seconds

  @low @benchmarking @notintegration
  Scenario: Quickly loading the licence finder home page
    Given I am benchmarking
    And I am testing through the full stack
    When I visit "/licence-finder"
    Then the elapsed time should be less than 1 seconds

  @normal @benchmarking @notintegration
  Scenario: Loading a pdf in a reasonable amount of time
    Given I am testing "licensing" internally
      And I am benchmarking
      And I am testing through the full stack
      And I force a varnish cache miss
    When I request "/apply-for-a-licence/forms/bury/test-licence/9999-7-1,0-1"
    Then the elapsed time should be less than 10 seconds

  @normal @benchmarking
  Scenario: Whitehall frontend website should be fast
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/how-government-works"
    Then the elapsed time should be less than 2 seconds

  @normal @benchmarking
  Scenario: Whitehall API should be fast
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/api/world-locations"
    Then the elapsed time should be less than 2 seconds

  @normal @benchmarking
  Scenario: National statistics release calendar should be fast
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/statistics/announcements"
    Then the elapsed time should be less than 2 seconds

Feature: Benchmarking
  Tests to check the loading times for various pages on GOV.UK.

  # TODO: IMPROVE this test.
  #
  # Remove the timing step as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (out-of-scope)
  # - Second critical check: N (not applicable)
  #
  @local-network
  Scenario: Check Bouncer application is up
    Given I am testing "bouncer" internally
    And I am benchmarking
    When I request "http://www.attorneygeneral.gov.uk" from Bouncer directly
    Then I should get a 301 status code
    And I should get a "Location" header of "https://www.gov.uk/government/organisations/attorney-generals-office"
    And the elapsed time should be less than 2 seconds

  # TODO: REMOVE this test as it is a duplicate.
  #
  # Duplicate of "Check licence finder loads".
  #
  # The timing step does not meet the elgibility criteria
  # in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (out-of-scope)
  # - Second critical check: N (not applicable)
  #
  Scenario: Check the licence finder home page loads quickly
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/licence-finder"
    Then the elapsed time should be less than 2 seconds

  # TODO: REMOVE this test as it is a duplicate.
  #
  # Duplicate of "Check licensing app is present".
  #
  # The timing step does not meet the elgibility criteria
  # in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (out-of-scope)
  # - Second critical check: N (not applicable)
  #
  Scenario: Check requesting a PDF takes a reasonable amount of time
    Given I am testing "licensing" internally
      And I am benchmarking
      And I am testing through the full stack
      And I force a varnish cache miss
      When I request "/apply-for-a-licence/forms/bury/test-licence/9999-7-1,0-1"
      Then the elapsed time should be less than 10 seconds

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered, out-of-scope)
  # - Second critical check: N (no feature tested)
  #
  # This page is actually rendered by Government Frontend. Data
  # transfer for this app with Content Store is already covered
  # by "Ensure static content is rendered".
  #
  Scenario: Check whitehall-frontend pages load quickly
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/how-government-works"
    Then the elapsed time should be less than 2 seconds

  # TODO: REMOVE this test as it is a duplicate.
  #
  # Duplicate of "Check the whitehall world locations API returns data".
  #
  # The timing step does not meet the elgibility criteria
  # in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (out-of-scope)
  # - Second critical check: N (not applicable)
  #
  Scenario: Check the whitehall API loads quickly
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/api/world-locations"
    Then the elapsed time should be less than 2 seconds

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered, out-of-scope)
  # - Second critical check: N (no feature tested)
  #
  # This page is rendered by Finder Frontend. Data transfer for
  # this app with Content Store and Search API is already covered
  # by e.g. "Check search results and analytics".
  #
  Scenario: Check the research and statistics page loads quickly
    Given I am benchmarking
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/search/research-and-statistics"
    Then the elapsed time should be less than 4 seconds

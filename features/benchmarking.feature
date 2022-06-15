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

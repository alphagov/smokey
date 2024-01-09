Feature: Smokey

  This is a quick sense check, run on every PR against Smokey itself,
  to verify that nothing is fundamentally broken.

  Scenario: Check that Smokey can make network requests
    When I visit "https://www.gov.uk"
    Then I should see "Welcome to GOV.UK"

  Scenario: Check that Smokey passes Rate Limit Token when set
    Given the 'RATE_LIMIT_TOKEN' ENV variable is set
    Then any request I make should include the 'Rate-Limit-Token' header

  Scenario: Check that Smokey doesn't attempt to pass Rate Limit Token if not set
    Given the 'RATE_LIMIT_TOKEN' ENV variable is NOT set
    Then any request I make should NOT include the 'Rate-Limit-Token' header

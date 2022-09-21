Feature: Smokey

  This is a quick sense check, run on every PR against Smokey itself,
  to verify that nothing is fundamentally broken.

  Scenario: Check that Smokey can make network requests
    When I request "https://www.gov.uk"
    Then I should get a 200 status code
    And I should see "Welcome to GOV.UK"

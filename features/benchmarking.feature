Feature: Benchmarking
  Tests to check the loading times for various pages on GOV.UK.

  @local-network
  Scenario: Check redirects work for transitioned sites
    Given I am testing "bouncer" internally
    When I request "http://www.attorneygeneral.gov.uk" from Bouncer directly
    Then I should get a 301 status code
    And I should get a "Location" header of "https://www.gov.uk/government/organisations/attorney-generals-office"

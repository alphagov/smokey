Feature: Bouncer

  @high
  Scenario: Bouncer application is up
    Given I am testing "bouncer"
    When I request "http://www.attorneygeneral.gov.uk" from Bouncer directly
    Then I should get a 301 status code
    And I should get a "Location" header of "https://www.gov.uk/government/organisations/attorney-generals-office"

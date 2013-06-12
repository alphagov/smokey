Feature: Fact Cave

  @notproduction
  Scenario: (Public) Fact Cave availability
    Given the "fact-cave" application has booted
    When I visit "/facts/vat-rate.json" on the "fact-cave" application
    Then I should get a 200 status code
    And I should see "The current Value Added Tax rate"

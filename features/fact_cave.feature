Feature: Fact Cave

  @local-network
  @normal
  Scenario: Internal Fact Cave availability
    Given the "fact-cave" application has booted
    When I visit "/facts/vat-rate.json" on the "fact-cave" application
    Then I should get a 200 status code
    And I should see "description"
    And I should see "value"

  @normal
  Scenario: Public Fact Cave availability
    Given the "fact-cave" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/api/facts/vat-rate.json"
    Then I should get a 200 status code
    And I should see "description"
    And I should see "value"

Feature: Browse

  @high
  Scenario: check browse pages load
    Given I am testing through the full stack
    And the "frontend" application has booted
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path            |
      | /browse         |
      | /browse/driving |

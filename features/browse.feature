Feature: Browse

  @high
  Scenario: check browse pages load
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path            |
      | /browse         |
    And I should be able to navigate the browse pages

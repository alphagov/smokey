Feature: Router

  @high
  Scenario: check router loads homepage
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path      |
      | /         |

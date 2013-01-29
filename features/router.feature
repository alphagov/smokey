Feature: Router

  @high
  Scenario: check router loads homepage
    Given the "frontend" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path      |
      | /         |

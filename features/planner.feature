Feature: Planner
  
  @notnagios
  Scenario: check planner loads
    Given the "planner" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path       |
      | /maternity |

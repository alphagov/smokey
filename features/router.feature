Feature: Router

  Scenario: check router loads homepage
    Given the "frontend" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path      |
      | /         |

  @notskyscape
  Scenario: check open ports on router
    Given I am testing through the full stack
    Then I should not be able to access critical ports
    And I should be able to access port 80
    And I should be able to access port 443


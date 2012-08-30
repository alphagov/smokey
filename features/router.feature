Feature: Router

  Scenario: check router loads homepage
    Given the "frontend" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path      |
      | /         |

  Scenario: check open ports on router
    Given I am testing through the full stack
    Then I should not be able to access critical ports
    And I should be able to access port 80
    And I should be able to access port 443

  @local-network @notnagios
  Scenario: check we can talk directly to the router
    When I visit "http://router.cluster:8080/router/routes/"
    Then I should get a 200 status code

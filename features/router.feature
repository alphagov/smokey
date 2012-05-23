Feature: Router

  Scenario: check router loads homepage
    Given I am testing "www"
    Then I should be able to visit:
      | Path      |
      | /         |

  Scenario: Check open ports on router
    Given I am testing "www"
    Then I should not be able to access critical ports
    And I should be able to access port 80
    And I should be able to access port 443

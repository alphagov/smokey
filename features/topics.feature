Feature: Topics

  Scenario: dynamically checking topic hierarchy
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path               |
      | /topic             |
    And I should be able to navigate the topic hierarchy

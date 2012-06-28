Feature: Smart Answers

  Scenario: check smart answers load
    Given the "smartanswers" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                |
      | /maternity-benefits |

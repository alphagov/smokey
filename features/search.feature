Feature: Search

  Scenario: check search loads
    Given the "search" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path            |
      | /search         |
      | /search?q=tax   |
      | /browse         |
      | /browse/driving |

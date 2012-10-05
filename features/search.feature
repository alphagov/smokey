Feature: Search

  Scenario: check search loads
    Given I am testing through the full stack
    And the "frontend" application has booted
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path            |
      | /search         |
      | /search?q=tax   |
      | /browse         |
      | /browse/driving |

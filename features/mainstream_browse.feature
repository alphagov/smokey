Feature: Mainstream Browse

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @high
  Scenario: Check mainstream browse pages load
    Then I should be able to visit:
      | Path            |
      | /browse         |
    And I should be able to navigate the browse pages

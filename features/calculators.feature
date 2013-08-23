Feature: Calculators app

  @normal
  Scenario: Accessing the child benefit tax calculator
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/child-benefit-tax-calculator"
    Then I should get a 200 status code
    When I visit "/child-benefit-tax-calculator/main"
    Then I should get a 200 status code

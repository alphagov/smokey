Feature: Calculators app

  @normal
  Scenario: Accessing the child benefit tax calculator
    Given I am testing through the full stack
    And I force a varnish cache miss

    When I visit "/child-benefit-tax-calculator"
    Then I should see "Child Benefit tax calculator"
     And The frontend app is "frontend"

    When I visit "/child-benefit-tax-calculator/main"
    Then I should see "Child Benefit tax calculator"
     And The frontend app is "calculators"

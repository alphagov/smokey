Feature: Calculators

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Check the child benefit tax calculator start page
    When I visit "/child-benefit-tax-calculator"
    Then I should see "Child Benefit tax calculator"

  Scenario: Check the child benefit tax calculator
    When I visit "/child-benefit-tax-calculator/main"
    Then I should see "Child Benefit tax calculator"
    And I should be able to see the previous tax year

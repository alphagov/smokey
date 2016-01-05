Feature: EFG

  Background:
    Given I am testing in an EFG context

  @notintegration
  @normal
  Scenario: Requires authenticated user to view lenders
    When I try to access the list of lenders
    Then I should be on the EFG home page

  @notintegration
  @normal
  Scenario: Quickly loading the EFG home page
    Given I am benchmarking
    When I visit the EFG home page
    Then the elapsed time should be less than 1 seconds

  @notintegration
  @normal
  Scenario: Can log in
    When I try to login as a valid EFG user
    Then I should be on the EFG post-login page


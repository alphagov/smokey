Feature: EFG

  @normal
  Scenario: Requires authenticated user to view lenders
    Given the "EFG" application has booted
    When I try to access the list of lenders
    Then I should be on the EFG home page

  @normal
  Scenario: Quickly loading the EFG home page
    Given the "EFG" application has booted
    And I am benchmarking
    When I visit the EFG home page
    Then the elapsed time should be less than 1 seconds

  @normal
  Scenario: Can log in
    Given the "EFG" application has booted
    When I try to login as a lender user
    Then I should be on the EFG lender user home page


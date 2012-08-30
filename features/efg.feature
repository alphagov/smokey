Feature: EFG
  Scenario: Requires authenticated user to view lenders
    Given the "EFG" application has booted
    When I try to access the list of lenders
    Then I should be on the EFG home page

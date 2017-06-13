Feature: Smart Answers

  @normal
  Scenario: check smart answers load
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                        |
      | /additional-commodity-code                  |
      | /calculate-employee-redundancy-pay          |
      | /calculate-married-couples-allowance        |
      | /marriage-abroad                            |
      | /pay-leave-for-parents                      |
      | /register-a-death                           |
      | /vat-payment-deadlines                      |

  @normal
  Scenario: step through a smart answer
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
    | Path                                        |
    | /vat-payment-deadlines                      |
    | /vat-payment-deadlines/y                    |
    | /vat-payment-deadlines/y/2000-01-31         |
    | /vat-payment-deadlines/y/2000-01-31/cheque  |

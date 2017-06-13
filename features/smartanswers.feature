Feature: Smart Answers

  @normal
  Scenario Outline: Check selected smart answer start pages
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "<smart_answer_start_page>" without following redirects
    Then I should get a 200 status code

    Examples:
      | smart_answer_start_page                     |
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

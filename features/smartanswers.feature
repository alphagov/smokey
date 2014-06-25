Feature: Smart Answers

  @normal
  Scenario: check smart answers load
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                        |
      | /additional-commodity-code                  |
      | /become-a-driving-instructor                |
      | /calculate-employee-redundancy-pay          |
      | /calculate-married-couples-allowance        |
      | /calculate-your-maternity-pay               |
      | /marriage-abroad                            |
      | /overseas-passports                         |
      | /register-a-death                           |

    @normal
    Scenario: step through a smart answer
      Given I am testing through the full stack
      And I force a varnish cache miss
      Then I should be able to visit:
      | Path                                              |
      | /student-finance-calculator                       |
      | /student-finance-calculator/y                     |
      | /student-finance-calculator/y/2013-2014           |
      | /student-finance-calculator/y/2013-2014/full-time |

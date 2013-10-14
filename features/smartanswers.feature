Feature: Smart Answers

  @normal
  Scenario: check smart answers load
    Given the "smartanswers" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                        |
      | /additional-commodity-code                  |
      | /become-a-driving-instructor                |
      | /become-a-motorcycle-instructor             |
      | /calculate-employee-redundancy-pay          |
      | /calculate-married-couples-allowance        |
      | /legal-right-to-work-in-the-uk              |
      | /calculate-your-maternity-pay               |
      | /register-a-death                           |

    @normal
    Scenario: step through a smart answer
      Given the "smartanswers" application has booted
      And I am testing through the full stack
      And I force a varnish cache miss
      Then I should be able to visit:
      | Path                                              |
      | /student-finance-calculator                       |
      | /student-finance-calculator/y                     |
      | /student-finance-calculator/y/2013-2014           |
      | /student-finance-calculator/y/2013-2014/full-time |

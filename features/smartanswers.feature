Feature: Smart Answers

  @normal
  Scenario: check smart answers load
    Given the "smartanswers" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
      | Path                                        |
      | /additional-commodity-code                  |
      | /am-i-getting-minimum-wage                  |
      | /appeal-a-benefits-decision                 |
      | /apply-for-probate                          |
      | /auto-enrolled-into-workplace-pension       |
      | /become-a-driving-instructor                |
      | /become-a-motorcycle-instructor             |
      | /benefits-if-you-are-abroad                 |
      | /calculate-agricultural-holiday-entitlement |
      | /maternity-benefits                         |

    @normal
    Scenario: step through a smart answer
    Given the "smartanswers" application has booted
    And I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
    | Path                                              |
    | /student-finance-calculator                       |
    | /student-finance-calculator/y                     |
    | /student-finance-calculator/y/2012-2013           |
    | /student-finance-calculator/y/2012-2013/full-time |
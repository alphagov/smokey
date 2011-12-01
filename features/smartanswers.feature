Feature: Smart Answers

  Scenario: check smart answers load
    Given I am testing "smartanswers"
    Then I should be able to visit:
      | Path                |
      | /maternity-benefits |

  @pending
  Scenario: check smart answers lacks home page
    Given I am testing "smartanswers"
    When I visit "/"
    Then I should see "Not found"
    And I should get a 404 status code

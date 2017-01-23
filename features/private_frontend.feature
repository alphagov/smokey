Feature: Private Frontend

  @normal
  Scenario: check private frontend requires auth
    Given I am testing "private-frontend"
    When I visit "/" without authentication
    Then I should get a 401 status code

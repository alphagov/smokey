Feature: Private Frontend

  @normal
  Scenario: check private frontend requires auth
    Given I am testing "private-frontend"
    And I am not an authenticated user
    When I try to request "/"
    Then I should get a 401 status code

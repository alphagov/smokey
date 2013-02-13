Feature: Private Frontend

  Background:
    Given the "private-frontend" application has booted
    And I am testing "private-frontend"
    And I am not an authenticated user

  @normal
  Scenario: check private frontend requires auth
    When I try to visit "/"
    Then I should get a 401 status code

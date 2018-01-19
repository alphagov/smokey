Feature: Assets

  @high
  Scenario: Assets are being served
    Given I am testing "assets"
    When I request "/__canary__"
    Then I should get a 200 status code

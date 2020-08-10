Feature: (Mainstream) Publisher

  @local-network
  Scenario: Healthcheck
    Given I am testing "publisher" internally
    When I request "/healthcheck"
    Then I should get a 200 status code

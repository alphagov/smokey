Feature: Apollo

  @local-network
  Scenario: check we can talk directly to apollo
    Given I connect to the queue on "support.cluster"
    When I send a ping to "/queue/smokey"
    Then I should be able to receive the message


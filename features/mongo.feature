Feature: MongoDB

  @local-network
  Scenario: check we can talk directly to mongodb
    Given I connect to the mongo instance on "mongodb.cluster"
    Then I should find the "publisher_production" database

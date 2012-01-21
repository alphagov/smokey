Feature: MySQL

  @local-network
  Scenario: check we can talk directly to mysql
    Given I connect to "panopticon_production" on "rds.cluster"
    Then I should be able to make a successful query with "SELECT 1"


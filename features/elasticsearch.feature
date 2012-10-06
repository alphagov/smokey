Feature: elasticsearch

  @local-network @high
  Scenario: check we can talk directly to elasticsearch
    When I visit "http://support.cluster:9200/_status"
    Then I should get a 200 status code
      And the status JSON should tell me it's okay

  @local-network @high
  Scenario: check the mainstream index exists and is healthy
    When I visit "http://support.cluster:9200/mainstream/_status"
    Then I should get a 200 status code
      And the status JSON should tell me it's okay

  @local-network @high
  Scenario: check the detailed guidance index exists and is healthy
    When I visit "http://support.cluster:9200/detailed/_status"
    Then I should get a 200 status code
      And the status JSON should tell me it's okay


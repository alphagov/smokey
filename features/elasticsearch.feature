Feature: elasticsearch

  @local-network
  Scenario: check we can talk directly to elasticsearch
    When I visit "http://support.cluster:9200/_status"
    Then I should get a 200 status code
      And the status JSON should tell me it's okay



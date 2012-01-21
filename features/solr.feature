Feature: Solr

  @local-network
  Scenario: check we can talk directly to solr
    When I visit "http://support.cluster:8983/solr/rummager/select?q=tax"
    Then I should get a 200 status code


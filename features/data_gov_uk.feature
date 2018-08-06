Feature: Data.gov.uk
  Tests for the new "Find open data service" on data.gov.uk

  Background:
    Given I am testing "https://find-data-beta.cloudapps.digital"
    And I force a varnish cache miss

  @high
  Scenario: Check home page loads
    When I request "/"
    Then I should see "Find open data"

  @high
  Scenario: Check search
    When I search for "data" in datasets
    Then I should see some dataset results

  @normal
  Scenario: Check RDF API
    When I request "/dataset/lidar-composite-dsm-1m1.rdf"
    Then I should get a 200 status code

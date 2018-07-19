Feature: Data.gov.uk
  This is the Find open data service at data.gov.uk

  Background:
    Given I am testing "https://find-data-beta.cloudapps.digital"
    And I force a varnish cache miss

  @high
  Scenario: check home page loads
    When I request "/"
    Then I should see "Find open data"

  @high @ignore_javascript_errors
  Scenario: check search
    When I search for "data" in datasets
    Then I should see some dataset results

  @normal
  Scenario: check RDF API
    When I request "/dataset/lidar-composite-dsm-1m1.rdf"
    Then I should get a 200 status code

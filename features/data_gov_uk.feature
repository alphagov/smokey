Feature: Data.gov.uk
  Tests for "Find open data" and CKAN on data.gov.uk

  @high
  Scenario: Check home page loads correctly
    Given I am testing "https://data.gov.uk"
    And I force a varnish cache miss
    When I request "/"
    Then I should see "Find open data"

  @high
  Scenario: Check search works
    Given I am testing "https://data.gov.uk"
    And I force a varnish cache miss
    When I search for "data" in datasets
    Then I should see some dataset results

  @normal
  Scenario: Check RDF API loads
    Given I am testing "https://data.gov.uk"
    And I force a varnish cache miss
    When I request "/dataset/lidar-composite-dsm-1m1.rdf"
    Then I should get a 200 status code

  @high
  Scenario: Check CKAN loads correctly
    Given I am testing "https://ckan.publishing.service.gov.uk"
    And I force a varnish cache miss
    When I request "/"
    Then I should see "Data publisher"

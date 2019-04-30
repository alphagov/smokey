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
    When I request "/"
    Then I should see "Data publisher"

  @high
  Scenario: Check datasets sync between CKAN and Find
    Given I am testing "https://ckan.publishing.service.gov.uk"
    When I request "/api/3/action/package_search"
    And I save the dataset count
    Given I am testing "https://data.gov.uk"
    And I force a varnish cache miss
    When I search for "" in datasets
    Then I should see a similar dataset count

  @high
  Scenario: Check there is an accurate number of datasets
    Given I am testing "https://data.gov.uk"
    And I force a varnish cache miss
    When I search for "" in datasets
    Then I should see an accurate dataset count

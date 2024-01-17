Feature: Data.gov.uk
  @notintegration @notstaging
  Scenario: Check home page loads correctly
    Given I am testing "https://data.gov.uk"
    When I visit "/"
    Then I should see "Find open data"

  @notintegration @notstaging
  Scenario: Check search works
    Given I am testing "https://data.gov.uk"
    When I search for "data" in datasets
    Then I should see some dataset results

  @notintegration @notstaging
  Scenario: Check RDF API loads
    Given I am testing "https://data.gov.uk"
    When I request "/dataset/lidar-composite-dtm-2017-1m.rdf"
    Then I should get a 200 status code

  @notintegration @notstaging @notreplatforming
  Scenario: Check CKAN loads correctly
    Given I am testing "ckan"
    When I visit "/"
    Then I should see "Data publisher"

  @notintegration @notstaging @notreplatforming
  Scenario: Check CKAN action api's search works
    Given I am testing "ckan"
    And I try not to bypass caching
    When I request "/api/action/package_search?q=data"
    Then I should get a 200 status code
    And JSON is returned

  @notintegration @notstaging
  Scenario: Check datasets sync between CKAN and Find
    Given I am testing "https://ckan.publishing.service.gov.uk"
    When I search for all datasets
    And I save the dataset count
    Given I am testing "https://data.gov.uk"
    When I search for "" in datasets
    Then I should see a similar dataset count

  @notintegration @notstaging
  Scenario: Check that we don't get any s3 CSP errors for organogram previews
    Given I am testing "https://data.gov.uk"
    When I preview an organogram
    Then I should see "View the full organogram"
    And I don't get any s3 CSP errors

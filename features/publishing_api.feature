@app-publishing-api @local-network
Feature: Publishing API
  Scenario: Healthcheck
    Given I am testing "publishing-api" internally
    When I request "/healthcheck"
    Then I should get a 200 status code

  Scenario: Getting a content item
    When I request the homepage from the Publishing API
    Then I receive a payload with the content

  Scenario: Getting content links
    When I request homepage links from the Publishing API
    Then I receive a payload with the expanded links

  Scenario: Getting linkables
    When I request organisation linkables from the Publishing API
    Then I receive a payload with all the organisations

Feature: Info Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario:
    When I visit "/info/browse/benefits"
    Then I should see "Benefits"
     And I should see "Unique pageviews"

Feature: Service Manual

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Visiting a topic page
    When I visit "/service-manual/agile-delivery"
    Then I should see "Agile delivery"
    And I should get a 200 status code

  Scenario: Visiting a guide page
    When I visit "/service-manual/agile-delivery/writing-user-stories"
    Then I should see "Writing user stories"
    And I should get a 200 status code

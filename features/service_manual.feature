Feature: Service Manual

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: Check Service Manual loads correctly
    When I visit "/service-manual"
    Then I should see "Service Manual"

  @normal
  Scenario: Check a topic page loads correctly
    When I visit "/service-manual/agile-delivery"
    Then I should see "Agile delivery"

  @normal
  Scenario: Check a guide page loads correctly
    When I visit "/service-manual/agile-delivery/writing-user-stories"
    Then I should see "Writing user stories"

  @normal
  Scenario: Check the service standard page loads correctly
    When I visit "/service-manual/service-standard"
    Then I should see "Digital Service Standard"

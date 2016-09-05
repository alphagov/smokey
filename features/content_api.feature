Feature: Content API

@high
Scenario: (Public) Content API availability
  Given I am testing through the full stack
  And I force a varnish cache miss
  When I visit "/api/vehicle-tax.json"
  Then I should get a 200 status code
  And I should see "Tax your vehicle"

Feature: Content API

@high
Scenario: (Public) Content API availability
  Given the "public-contentapi" application has booted
  And I am testing through the full stack
  And I force a varnish cache miss
  When I visit "/api/tags.json"
  Then I should get a 200 status code
  And I should see "Business Link"

Feature: Mirror

# These Cucumber tests run against the mirrors.
# Despite the fact that Varnish doesn't run in static, we force cachebusts anyway in case we do run Varnish on static in future.

  @high
    Scenario: check for HTTP 200 response
      Given I am testing through the full stack
      And I force a varnish cache miss
      When I visit "/"
      Then I should get a 200 status code
 
  @high
    Scenario: check for correct homepage content
      Given I am testing through the full stack
      And I force a varnish cache miss
      Then I should see the departments and policies section on the homepage
      And I should see the services and information section on the homepage

  @normal
    Scenario: check for correct response from deep-linked page
      Given I am testing through the full stack
      And I force a varnish cache miss
      When I visit "/council-tax-reduction"
      Then I should get a 200 status code

  @normal
    Scenario: check search returns a 503
    # Search is a separate application which will not be booted, therefore searches should return 503
      Given I am testing through the full stack
      And I force a varnish cache miss
      When I search for "cheesecake"
      Then I should get a 503 status code
      And I should see "This page cannot be found"

  @normal
    Scenario: Return a 503 for 404s
    # On static, we return 503s for 404s
      Given I am testing through the full stack
      And I force a varnish cache miss
      When I visit "/jasdu3jjasd"
      Then I should get a 503 status code

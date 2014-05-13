Feature: Mirror

    @high
    Scenario: Check homepage is served by all the mirrors
      Given there are 2 mirrors and 2 providers
      Then I should get a 200 response from "/" on the mirrors

    @high
    Scenario: Check a deep-linked page is served by all the mirrors
      Given there are 2 mirrors and 2 providers
      Then I should get a 200 response from "/council-tax-reduction" on the mirrors

    @high
    Scenario: Check a non-existent page returns a service-unavailable error from all the mirrors
      Given there are 2 mirrors and 2 providers
      Then I should get a 503 response from "/jasdu3jjasd" on the mirrors

    @high
    Scenario: Check that search returns an error on all the mirrors
      Given there are 2 mirrors and 2 providers
      Then I should get a 503 response from "/search" on the mirrors

@local-network
Feature: Mirror

    @high
    Scenario: Check homepage is served by the load-balanced mirrors
      Given there are 2 mirror providers
      Then I should get a 200 response from "/" on the mirrors
      And I should see "Welcome to GOV.UK"

    @high
    Scenario: Check that search returns an error on the load-balanced mirrors
      Given there are 2 mirror providers
      Then I should get a 503 response from "/search" on the mirrors
      And I should see a technical difficulties message

    @high
    Scenario: Check homepage is served by all the mirrors
      Given there are 2 mirrors and 2 providers
      Then I should get a 200 response from "/" on the mirrors
      And I should see "Welcome to GOV.UK"

    @high
    Scenario: Check a deep-linked page is served by all the mirrors
      Given there are 2 mirrors and 2 providers
      Then I should get a 200 response from "/book-theory-test" on the mirrors
      And I should see "Book your theory test"

    @high
    Scenario: Check a non-existent page returns a service-unavailable error from all the mirrors
      Given there are 2 mirrors and 2 providers
      Then I should get a 503 response from "/jasdu3jjasd" on the mirrors
      And I should see a technical difficulties message

    @high
    Scenario: Check that search returns an error on all the mirrors
      Given there are 2 mirrors and 2 providers
      Then I should get a 503 response from "/search" on the mirrors
      And I should see a technical difficulties message

@local-network
Feature: Mirror
    Tests for the GOV.UK mirrors that serve content if origin is unavailable.

    @notintegration @notstaging
    Scenario: Check homepage is served by all the mirrors
      Given S3 mirrors
      Then I should get a 200 response from "/www.gov.uk/index.html" on the mirrors
      And I should see "Welcome to GOV.UK"

    @notintegration @notstaging
    Scenario: Check a deep-linked page is served by all the mirrors
      Given S3 mirrors
      Then I should get a 200 response from "/www.gov.uk/book-theory-test.html" on the mirrors
      And I should see "Book your theory test"

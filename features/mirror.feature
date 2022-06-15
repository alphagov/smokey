@local-network
Feature: Mirror
    Tests for the GOV.UK mirrors that serve content if origin is unavailable.

    # TODO: REMOVE this test as it is a duplicate.
    #
    # Duplicate of "Check homepage is served by all the mirrors"
    #
    @notintegration @notstaging
    Scenario: Check Fastly probe request
      Given S3 mirrors
      Then I should get a 200 response from "/www.gov.uk/index.html" on the mirrors

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

    # TODO: REMOVE this test as it does not meet the eligibility
    # criteria in docs/writing-tests.md.
    #
    # - Covers site-wide config: N (edge case)
    # - Targets data transfer: N (not applicable)
    # - Second critical check: N (not applicable)
    #
    @notintegration @notstaging
    Scenario: Check a non-existent page returns a AccessDenied error from all the mirrors
      Given S3 mirrors
      Then I should get a 403 response from "/www.gov.uk/jasdu3jjasd" on the mirrors

    # TODO: REMOVE this test as it does not meet the eligibility
    # criteria in docs/writing-tests.md.
    #
    # - Covers site-wide config: N (edge case)
    # - Targets data transfer: N (not applicable)
    # - Second critical check: N (not applicable)
    #
    @notintegration @notstaging
    Scenario: Check that search returns an error on all the mirrors
      Given S3 mirrors
      Then I should get a 403 response from "/www.gov.uk/search" on the mirrors

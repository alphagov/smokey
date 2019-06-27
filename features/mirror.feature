@aws @local-network
Feature: Mirror
    Tests for the GOV.UK mirrors that serve content if origin is unavailable.	

    @high @notintegration @notstaging @nottraining
    Scenario: Check Fastly probe request
      Given S3 mirrors
      Then I should get a 200 response from "/www.gov.uk/index.html" on the mirrors

    @high @notintegration @notstaging @nottraining
    Scenario: Check homepage is served by all the mirrors
      Given S3 mirrors
      Then I should get a 200 response from "/www.gov.uk/index.html" on the mirrors
      And I should see "Welcome to GOV.UK"

    @high @notintegration @notstaging @nottraining
    Scenario: Check a deep-linked page is served by all the mirrors
      Given S3 mirrors
      Then I should get a 200 response from "/www.gov.uk/book-theory-test.html" on the mirrors
      And I should see "Book your theory test"

    @high @notintegration @notstaging @nottraining
    Scenario: Check a non-existent page returns a AccessDenied error from all the mirrors
      Given S3 mirrors
      Then I should get a 403 response from "/www.gov.uk/jasdu3jjasd" on the mirrors

    @high @notintegration @notstaging @nottraining
    Scenario: Check that search returns an error on all the mirrors
      Given S3 mirrors
      Then I should get a 403 response from "/www.gov.uk/search" on the mirrors

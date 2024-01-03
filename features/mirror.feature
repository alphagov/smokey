@local-network
Feature: Mirror
  @notintegration @notstaging
  Scenario Outline: Check homepage is served by all the mirrors
    Given there is an S3 mirror <mirror>
    Then I should get a 200 response from "/www.gov.uk/index.html" on the mirror
    And I should see "Welcome to GOV.UK"

    Examples:
      | mirror                                                   |
      | https://govuk-production-mirror.s3.amazonaws.com         |
      | https://govuk-production-mirror-replica.s3.amazonaws.com |

  @notintegration @notstaging
  Scenario Outline: Check a deep-linked page is served by all the mirrors
    Given there is an S3 mirror <mirror>
    Then I should get a 200 response from "/www.gov.uk/book-theory-test.html" on the mirror
    And I should see "Book your theory test"

    Examples:
      | mirror                                                   |
      | https://govuk-production-mirror.s3.amazonaws.com         |
      | https://govuk-production-mirror-replica.s3.amazonaws.com |

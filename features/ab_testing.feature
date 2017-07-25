# Tests for the example A/B testing page. Even though these just test an example
# page, they're still a useful smoke test of real A/B experiments, because they
# all A/B tests rely on CDN config to assign users into buckets and handle A/B
# cookies correctly. So a failure in these tests indicates that all A/B tests
# may be broken.
#
# These tests are only run against Production because they rely on the CDN to
# manipulate the HTTP request and response headers.
Feature: A/B Testing

  @low @notintegration @notstaging
  Scenario: check we end up in all buckets
    Given there is an AB test setup
    And I am testing through the full stack
    When multiple new users visit "/help/ab-testing"
    Then we have shown them all versions of the AB test

  @withanalytics @low @notintegration @notstaging
  Scenario: check that an A/B test works
    Given there is an AB test setup
    And I am testing through the full stack
    And I do not have any AB testing cookies set
    When I visit "/help/ab-testing"
    Then I am assigned to a test bucket
    And I can see the bucket I am assigned to
    And the bucket is reported to Google Analytics
    And I stay on the same bucket when I keep visiting "/help/ab-testing"

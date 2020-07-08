Feature: A/B Testing
  Tests for the example A/B testing page. Even though these just test an example
  page, they're still a useful smoke test of real A/B experiments, because all
  A/B tests rely on CDN config to assign users into buckets and handle A/B
  cookies correctly. So a failure in these tests indicates that all A/B tests
  may be broken.

  Background:
    Given there is an A/B test set up
    And I consent to cookies
    And I am testing through the full stack

  Scenario: Check we end up in all buckets
    When multiple new users visit "/help/ab-testing"
    Then we have shown them all versions of the A/B test

  Scenario: Check that an A/B test works
    And I do not have any A/B testing cookies set
    When I visit "/help/ab-testing"
    Then I am assigned to a test bucket
    And I can see the bucket I am assigned to
    And the bucket is reported to Google Analytics
    And I stay on the same bucket when I keep visiting "/help/ab-testing"

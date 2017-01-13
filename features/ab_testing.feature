Feature: A/B Testing

  # FIXME: Add @notstaging or direct request through CDN on Staging
  @low @notintegration
  Scenario: check we end up in all buckets
    Given there is an AB test setup
    And I am testing through the full stack
    When multiple new users visit "/help/ab-testing"
    Then we have shown them all versions of the AB test

  @low @notintegration
  Scenario: check that an A/B test works
    Given there is an AB test setup
    And I am testing through the full stack
    And I do not have any AB testing cookies set
    When I visit "/help/ab-testing"
    Then I am assigned to a test bucket
    And I can see the bucket I am assigned to
    And the bucket is reported to Google Analytics
    And I stay on the same bucket when I keep visiting "/help/ab-testing"

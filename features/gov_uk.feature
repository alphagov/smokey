@replatforming
Feature: Core GOV.UK behaviour
  Tests for core URL and link behaviour on GOV.UK.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (edge case)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not applicable)
  #
  # The low impact and likelihood of this breaking compared to
  # any other CDN feature means the risk of removal is low.
  #
  # No evidence this is a vital feature [^1].
  #
  # [^1]: https://github.com/alphagov/smokey/commit/436cdce8460b22baf654e1f3342ae36846bb6567
  #
  Scenario: Check paths with a trailing slash are redirected
    When I visit "/browse/benefits/" without following redirects
    Then I should get a 301 status code
    And I should be at a location path of "/browse/benefits"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (edge case)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not applicable)
  #
  # The low impact and likelihood of this breaking compared to
  # any other CDN feature means the risk of removal is low.
  #
  # No evidence this is a vital feature [^1].
  #
  # [^1]: https://github.com/alphagov/smokey/commit/1ab8b52820d302b48cf3949a13449e5446d63fe7
  #
  Scenario: Check paths with a trailing full stop are redirected
    When I visit "/browse/benefits." without following redirects
    Then I should get a 301 status code
    And I should be at a location path of "/browse/benefits"

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # This page is rendered by Frontend. Data transfer for this
  # app with Static is already covered by
  # "Check feedback component behaviour".
  #
  # Should be tested in Static [^1].
  #
  # [^1]: https://github.com/alphagov/static/blob/9f835b87a3aa6ed867b98b2f4534dd64c9510626/app/views/root/_gem_base.html.erb#L43
  #
  Scenario: Check the crown logo links to GOV.UK homepage
    When I visit "/"
    Then the logo should link to the homepage

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (edge case)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not applicable)
  #
  # The low impact and likelihood of this breaking compared to
  # any other CDN feature means the risk of removal is low.
  #
  # No evidence this is a vital feature [^1].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/186
  #
  Scenario: Check entirely upper case slugs redirect to lowercase
    When I visit "/GOVERNMENT/ORGANISATIONS" without following redirects
    Then I should get a 301 status code
    And I should be at a location path of "/government/organisations"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (edge case)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not applicable)
  #
  # We do not test unhappy paths in this repo.
  #
  Scenario: Check partially upper case slugs do not redirect
    When I visit "/government/organisaTIONS" without following redirects
    Then I should see "Page not found"

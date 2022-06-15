@replatforming
Feature: Core GOV.UK behaviour
  Tests for core URL and link behaviour on GOV.UK.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

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

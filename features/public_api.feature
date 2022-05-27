@replatforming
Feature: Public API

  Background:
    Given I am testing through the full stack

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (no other apps involved)
  # - Second critical check: N (no feature tested)
  #
  # This app already has basic coverage from "Check sitemap".
  # Also tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/search-api/blob/384358a13c8895ff888ea24f8c68b52c872a0d27/spec/integration/search/search_spec.rb#L404
  #
  Scenario: Check the search API returns data
    Given I force a varnish cache miss for search
    When I request "/api/search.json"
    Then I should get a 200 status code
    And JSON is returned

  Scenario: Check the content store returns data
    Given I force a varnish cache miss
    When I request "/api/content/help"
    Then I should get a 200 status code
    And JSON is returned

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not a critical feature)
  #
  # Data transfer with Search API is already covered by
  # "Check services and information page loads correctly".
  #
  # No evidence this is a critical feature [^1].
  #
  # Also tested in app [^2].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/273
  # [^1]: https://github.com/alphagov/collections/blob/31ff3c5e5eac08af97369343446b32227c6d3a78/spec/controllers/organisations_api_controller_spec.rb
  #
  Scenario: Check the collections organisations API returns data
    Given I force a varnish cache miss
    When I request "/api/organisations"
    Then I should get a 200 status code
    And JSON is returned

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not a critical feature)
  #
  # Data transfer with Search API is already covered by
  # "Check services and information page loads correctly".
  #
  # No evidence this is a critical feature [^1].
  #
  # Also tested in app [^2].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/273
  # [^1]: https://github.com/alphagov/collections/blob/31ff3c5e5eac08af97369343446b32227c6d3a78/spec/controllers/organisations_api_controller_spec.rb
  #
  Scenario: Check the collections organisation API returns data
    Given I force a varnish cache miss
    When I request "/api/organisations/hm-revenue-customs"
    Then I should get a 200 status code
    And JSON is returned

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (no other apps involved)
  # - Second critical check: N (not a critical feature)
  #
  # No evidence this is a critical feature [^1]. This app already
  # has basic coverage from "Check whitehall pages load".
  #
  # Also tested in app [^2].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/273
  # [^1]: https://github.com/alphagov/whitehall/blob/d670f6f30a0155d5d9f3f5f50ed86b4bec567cb2/test/functional/api/governments_controller_test.rb
  #
  Scenario: Check the whitehall governments API returns data
    Given I force a varnish cache miss
    When I request "/api/governments"
    Then I should get a 200 status code
    And JSON is returned

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (no other apps involved)
  # - Second critical check: N (not a critical feature)
  #
  # No evidence this is a critical feature [^1]. This app already
  # has basic coverage from "Check whitehall pages load".
  #
  # Also tested in app [^2].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/273
  # [^2]: https://github.com/alphagov/whitehall/blob/d670f6f30a0155d5d9f3f5f50ed86b4bec567cb2/test/functional/api/world_locations_controller_test.rb
  #
  Scenario: Check the whitehall world locations API returns data
    Given I force a varnish cache miss
    When I request "/api/world-locations"
    Then I should get a 200 status code
    And JSON is returned

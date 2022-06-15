@replatforming @app-service-manual-frontend
Feature: Service Manual

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Check Service Manual loads correctly
    When I visit "/service-manual"
    Then I should see "Service Manual"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not a critical feature)
  #
  # Tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/service-manual-frontend/blob/163cac84db292eb782df33c86ca05cf9e0830f17/test/integration/topic_test.rb
  #
  Scenario: Check a topic page loads correctly
    When I visit "/service-manual/agile-delivery"
    Then I should see "Agile delivery"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not a critical feature)
  #
  # Tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/service-manual-frontend/blob/163cac84db292eb782df33c86ca05cf9e0830f17/test/integration/guide_test.rb
  #
  Scenario: Check a guide page loads correctly
    When I visit "/service-manual/agile-delivery/writing-user-stories"
    Then I should see "Writing user stories"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not a critical feature)
  #
  # Tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/service-manual-frontend/blob/163cac84db292eb782df33c86ca05cf9e0830f17/test/integration/service_standard_test.rb
  #
  Scenario: Check the service standard page loads correctly
    When I visit "/service-manual/service-standard"
    Then I should see "Service Standard"

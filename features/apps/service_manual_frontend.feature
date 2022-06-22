@replatforming @app-service-manual-frontend
Feature: Service Manual Frontend

  Scenario: Check the frontend can talk to Content Store
    When I visit "/service-manual"
    Then I should see "Service Manual"

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not tested in app)
  #
  # Should be tested in Service Manual Frontend, if at all, when
  # the app takes over from Static and renders its own layout [^1].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/976#discussion_r903528402
  #
  Scenario: Check the feedback component loads
    When I visit "/service-manual"
    And I confirm it is rendered by "service-manual-frontend"
    And I can operate the feedback component

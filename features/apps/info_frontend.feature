@app-info-frontend @replatforming
Feature: Info Frontend

  Scenario: Check the frontend can talk to Content Store
    When I visit "/info/sign-in-universal-credit"
    Then I should see "The user need for this page"

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not tested in app)
  #
  # Should be tested in Info Frontend, if at all, when the app
  # takes over from Static and renders its own layout [^1].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/976#discussion_r903528402
  #
  Scenario: Check the feedback component loads
    When I visit "/info/vat-rates"
    And I confirm it is rendered by "info-frontend"
    And I can operate the feedback component

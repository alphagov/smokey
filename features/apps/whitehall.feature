@replatforming @app-whitehall
Feature: Whitehall
  Scenario: Check the frontend can talk to Content Store
    When I request "/government/ministers"
    Then I should see "Ministers by department"

  @app-asset-manager
  Scenario: Check whitehall assets are redirected to and served from the asset host
    When I request an attachment
    Then I should be redirected to the asset host
    And the attachment should be served successfully

  @app-asset-manager
  Scenario: Check the frontend can talk to Asset Manager
    When I visit "/government/uploads/system/uploads/attachment_data/file/214962/passport-impact-indicat.csv/preview"
    Then JavaScript should run without any errors

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not tested in app)
  #
  # Should be tested in Whitehall, if at all, when the app takes
  # over from Static and renders its own layout [^1].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/976#discussion_r903528402
  #
  Scenario: Check the feedback component loads
    When I visit "/world"
    And I confirm it is rendered by "whitehall"
    And I can operate the feedback component

  @app-publishing-api
  Scenario: Can log in to whitehall
    When I go to the "whitehall-admin" landing page
    And I try to login as a user
    And I go to the "whitehall-admin" landing page
    Then I should see "GOV.UK Whitehall"
    And I should see "Logout"
    And I should see "Dashboard"
    And I should see "My draft documents"

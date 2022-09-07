@replatforming @app-whitehall
Feature: Whitehall
  Scenario: Check the frontend can talk to Content Store
    When I request "/government/ministers"
    Then I should either see "ministers by department" or "This page is being updated."

  @app-asset-manager
  Scenario: Check whitehall assets are redirected to and served from the asset host
    When I request an attachment
    Then I should be redirected to the asset host
    And the attachment should be served successfully

  @app-asset-manager
  Scenario: Check the frontend can talk to Asset Manager
    When I visit "/government/uploads/system/uploads/attachment_data/file/214962/passport-impact-indicat.csv/preview"
    Then JavaScript should run without any errors

  @app-publishing-api @notreplatforming
  Scenario: Can log in to whitehall
    When I go to the "whitehall-admin" landing page
    And I try to login as a user
    And I go to the "whitehall-admin" landing page
    Then I should see "GOV.UK Whitehall"
    And I should see "Logout"
    And I should see "Dashboard"
    And I should see "My draft documents"

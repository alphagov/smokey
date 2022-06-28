@replatforming @app-feedback
Feature: Feedback

  Scenario: Check the frontend can talk to Content Store
    When I visit "/contact/govuk"
    Then I should see "Contact GOV.UK"

  # TODO: EXPORT this test as it does not meet the elgibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # Data transfer with Content Store is already covered by
  # "Check the frontend can talk to Content Store".
  #
  # Should be tested in Feedback [^1].
  #
  # [^1]: https://github.com/alphagov/feedback/blob/d2e8d8286fffec6b6093eecd5ed2d38f2c245e9e/app/models/contact_ticket.rb#L16
  #
  Scenario: Check malicious code does not execute
    When I visit "/contact/govuk"
    And I input malicious code in the email field
    Then I see the code returned in the page

  Scenario: Check "is this page useful?" email survey
    When I visit "/"
    And I click to say the page is not useful
    And I submit the email survey signup form
    Then I see the feedback confirmation message
    And a request is sent to the feedback app
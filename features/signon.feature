@app-signon @replatforming
Feature: Signon
  Tests for signon, the GOV.UK single sign-on service.

  Scenario: Check logging in works
    When I try to login as a user
    Then I should see "Your applications"

  # TODO: EXPORT this test as it does not meet the elgibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (no other apps involved)
  # - Second critical check: N (not tested in app)
  #
  # Should be tested in Signon [^1].
  #
  # [^1]: https://github.com/alphagov/signon/blob/c9f9c829f7c1a8fc6712cd6c15c2c2f5412db02d/config/initializers/session_store.rb#L5
  #
  Scenario: Check signon cookies are marked as secure
    When I go to the "signon" landing page
    Then I should receive a "_signonotron2_session" cookie which is "secure"

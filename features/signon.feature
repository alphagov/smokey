Feature: Signon
  Tests for signon, the GOV.UK single sign-on service.

  @high
  Scenario: Check logging in works
    When I try to login as a user
    Then I should see "Your applications"

  @low
  Scenario: Check signon cookies are marked as secure
    When I go to the "signon" landing page
    Then I should receive a "_signonotron2_session" cookie which is "secure"

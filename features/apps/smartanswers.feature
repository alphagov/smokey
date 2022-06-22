@app-smartanswers @replatforming
Feature: Smart Answers

  Scenario: Check the app is routable for a Smart Answer
    Then I should be able to visit:
    | Path                                        |
    | /vat-payment-deadlines                      |
    | /vat-payment-deadlines/y                    |
    | /vat-payment-deadlines/y/2000-01-31         |
    | /vat-payment-deadlines/y/2000-01-31/cheque  |

  Scenario: Check the frontend can talk to Worldwide API
    When I request "/check-uk-visa/y"
    Then I should see a populated country select

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not tested in app)
  #
  # Should be tested in Smart Answers, if at all, when the app
  # takes over from Static and renders its own layout [^1].
  #
  # [^1]: https://github.com/alphagov/smokey/pull/976#discussion_r903528402
  #
  Scenario: Check the feedback component loads
    When I visit "/marriage-abroad"
    And I confirm it is rendered by "smartanswers"
    And I can operate the feedback component

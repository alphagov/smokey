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

  Scenario: Check the feedback component loads
    When I visit "/marriage-abroad"
    And I confirm it is rendered by "smartanswers"
    And I click to report a problem with the page
    Then I see the report a problem form
    When I close the open feedback form
    And I click to say the page is not useful
    Then I see the email survey signup form
    When I close the open feedback form
    And I click to say the page is useful
    Then I see the feedback confirmation message

@app-smartanswers
Feature: Smart Answers

  Scenario: Check the app is routable for a Smart Answer
    Then I should be able to visit:
    | Path                                        |
    | /vat-payment-deadlines                      |
    | /vat-payment-deadlines/y                    |
    | /vat-payment-deadlines/y/2000-01-31         |
    | /vat-payment-deadlines/y/2000-01-31/cheque  |

  @worksonmirror
  Scenario: Check the frontend can talk to Worldwide API
    When I visit "/check-uk-visa/y"
    Then I should see a populated country select

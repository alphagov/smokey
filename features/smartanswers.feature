@app-smartanswers @replatforming
Feature: Smart Answers

  Scenario: Check stepping through a smart answer
    Then I should be able to visit:
    | Path                                        |
    | /vat-payment-deadlines                      |
    | /vat-payment-deadlines/y                    |
    | /vat-payment-deadlines/y/2000-01-31         |
    | /vat-payment-deadlines/y/2000-01-31/cheque  |

  Scenario: Check the frontend can talk to Worldwide API
    When I request "/check-uk-visa/y"
    Then I should see a populated country select

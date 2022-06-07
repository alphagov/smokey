@app-smartanswers @replatforming
Feature: Smart Answers

  Background:
    Given I force a varnish cache miss

  Scenario: Check stepping through a smart answer
    Then I should be able to visit:
    | Path                                        |
    | /vat-payment-deadlines                      |
    | /vat-payment-deadlines/y                    |
    | /vat-payment-deadlines/y/2000-01-31         |
    | /vat-payment-deadlines/y/2000-01-31/cheque  |

  # TODO: RENAME to clarify this is testing data transfer with
  # Worldwide API.
  #
  Scenario Outline: Check viewing countries in a select element
    When I request "<Path>"
    Then I should see a populated country select

    Examples:
      | Path                                                       |
      | /check-uk-visa/y                                           |

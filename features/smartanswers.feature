@aws @app-smartanswers
Feature: Smart Answers

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario Outline: Check selected smart answer start pages
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                        | Expected string                                      |
      | /additional-commodity-code/y                | How much starch or glucose does the product contain? |
      | /calculate-employee-redundancy-pay/y        | What date was your employee made redundant?          |
      | /calculate-married-couples-allowance/y      | Were you or your partner born before 6 April 1935?   |
      | /marriage-abroad/y                          | Where do you want to get married?                    |
      | /pay-leave-for-parents/y                    | Will the mother care for the child with a partner?   |
      | /register-a-death/y                         | Where did the death happen?                          |
      | /vat-payment-deadlines/y                    | When does your VAT accounting period end?            |

  Scenario: Check stepping through a smart answer
    Then I should be able to visit:
    | Path                                        |
    | /vat-payment-deadlines                      |
    | /vat-payment-deadlines/y                    |
    | /vat-payment-deadlines/y/2000-01-31         |
    | /vat-payment-deadlines/y/2000-01-31/cheque  |

  Scenario: Check stepping through a smart answer that uses Imminence
    Then I should be able to visit:
    | Path                                              |
    | /landlord-immigration-check                       |
    | /landlord-immigration-check/y                     |
    | /landlord-immigration-check/y/SW1A2AA             |
    | /landlord-immigration-check/y/SW1A2AA/yes         |
    | /landlord-immigration-check/y/SW1A2AA/yes/yes     |
    | /landlord-immigration-check/y/SW1A2AA/yes/yes/yes |

  Scenario: Check stepping through a smart answer that uses the Worldwide API
    Then I should be able to visit:
    | Path                                                |
    | /marriage-abroad                                    |
    | /marriage-abroad/y                                  |
    | /marriage-abroad/y/sweden                           |
    | /marriage-abroad/y/sweden/uk                        |
    | /marriage-abroad/y/sweden/uk/partner_other          |
    | /marriage-abroad/y/sweden/uk/partner_other/same_sex |

  Scenario Outline: Check viewing countries in a select element
    When I request "<Path>"
    Then I should see a populated country select

    Examples:
      | Path                                                       |
      | /check-uk-visa/y                                           |
      | /help-if-you-are-arrested-abroad/y                         |
      | /marriage-abroad/y                                         |
      | /register-a-birth/y                                        |
      | /register-a-birth/y/afghanistan/father/yes/another_country |
      | /register-a-death/y/overseas                               |
      | /register-a-death/y/overseas/afghanistan/another_country   |
      | /uk-benefits-abroad/y/going_abroad/child_benefit           |

  Scenario Outline: Check country names are correctly formatted
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                                                         | Expected string                                    |
      | /marriage-abroad/y/netherlands/ceremony_country/partner_british/opposite_sex | local authorities in the Netherlands               |
      | /marriage-abroad/y/cayman-islands/uk/partner_british/opposite_sex            | The Cayman Islands is a British overseas territory |
      | /register-a-birth/y/cayman-islands                                           | regulations in the Cayman Islands                  |
      | /register-a-death/y/overseas/cayman-islands                                  | regulations in the Cayman Islands                  |

  Scenario Outline: Check country slugs are correctly validated
    When I request "<Path>"
    Then the slug should be <Valid>

    Examples:
      | Path                                                   | Valid   |
      | /marriage-abroad/y/netherlands                         | valid   |
      | /marriage-abroad/y/foo                                 | invalid |
      | /register-a-birth/y/cayman-islands                     | valid   |
      | /register-a-birth/y/foo                                | invalid |
      | /register-a-death/y/overseas/cayman-islands            | valid   |
      | /register-a-death/y/overseas/foo                       | invalid |
      | /help-if-you-are-arrested-abroad/y/afghanistan         | valid   |
      | /help-if-you-are-arrested-abroad/y/foo                 | invalid |

  Scenario Outline: Check country FCOs can be looked up
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                                           | Expected string                 |
      | /marriage-abroad/y/afghanistan/uk/partner_british/opposite_sex | Embassy of Afghanistan          |
      | /register-a-death/y/overseas/north-korea/same_country          | British Embassy Pyongyang       |

  Scenario Outline: Check postcode lookup
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                                                              | Expected string            |
      | /benefit-cap-calculator/y/yes/no/none/bereavement/1000.0/1000.0/single/SW1A%202AA | Greater London benefit cap |
      | /benefit-cap-calculator/y/yes/no/none/bereavement/1000.0/1000.0/single/EH99%201SP | Outside London benefit cap |
      | /landlord-immigration-check/y/SW1A%202AA                                          | Is the person renting      |
      | /landlord-immigration-check/y/EH99%201SP                                          | check in England           |

  Scenario: Check personal information is excluded from analytics data
    When I visit "/marriage-abroad/y"
    Then I should see that postcodes are stripped from analytics data

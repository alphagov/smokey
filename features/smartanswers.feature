Feature: Smart Answers

  @normal
  Scenario: Check selected smart answer start pages
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
    | Path                                        |
    | /additional-commodity-code/y                |
    | /calculate-employee-redundancy-pay/y        |
    | /calculate-married-couples-allowance/y      |
    | /marriage-abroad/y                          |
    | /pay-leave-for-parents/y                    |
    | /register-a-death/y                         |
    | /vat-payment-deadlines/y                    |
    And I should get a 200 status code

  @normal
  Scenario: step through a smart answer
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
    | Path                                        |
    | /vat-payment-deadlines                      |
    | /vat-payment-deadlines/y                    |
    | /vat-payment-deadlines/y/2000-01-31         |
    | /vat-payment-deadlines/y/2000-01-31/cheque  |

  @normal
  Scenario: Step through a smart answer using Imminence
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
    | Path                                              |
    | /landlord-immigration-check                       |
    | /landlord-immigration-check/y                     |
    | /landlord-immigration-check/y/SW1A2AA             |
    | /landlord-immigration-check/y/SW1A2AA/yes         |
    | /landlord-immigration-check/y/SW1A2AA/yes/yes     |
    | /landlord-immigration-check/y/SW1A2AA/yes/yes/yes |

  @normal
  Scenario: Step through a smart answer using the Worldwide API
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
    | Path                                                |
    | /marriage-abroad                                    |
    | /marriage-abroad/y                                  |
    | /marriage-abroad/y/sweden                           |
    | /marriage-abroad/y/sweden/uk                        |
    | /marriage-abroad/y/sweden/uk/partner_other          |
    | /marriage-abroad/y/sweden/uk/partner_other/same_sex |

  @normal
  Scenario Outline: Viewing countries in a select element
    Given I am testing through the full stack
    And I force a varnish cache miss
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
      | /report-a-lost-or-stolen-passport/y/abroad                 |
      | /uk-benefits-abroad/y/going_abroad/child_benefit           |

  @normal
  Scenario Outline: Country names are correctly formatted
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                                                         | Expected string                                    |
      | /marriage-abroad/y/netherlands/ceremony_country/partner_british/opposite_sex | local authorities in the Netherlands               |
      | /marriage-abroad/y/cayman-islands/uk/partner_british/opposite_sex            | The Cayman Islands is a British overseas territory |
      | /register-a-birth/y/cayman-islands                                           | regulations in the Cayman Islands                  |
      | /register-a-death/y/overseas/cayman-islands                                  | regulations in the Cayman Islands                  |

  @normal
  Scenario Outline: Country slugs are correctly validated
    Given I am testing through the full stack
    And I force a varnish cache miss
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
      | /report-a-lost-or-stolen-passport/y/abroad/afghanistan | valid   |
      | /report-a-lost-or-stolen-passport/y/abroad/foo         | invalid |

  @normal
  Scenario Outline: Country FCOs can be looked up
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                                           | Expected string                 |
      | /marriage-abroad/y/afghanistan/uk/partner_british/opposite_sex | Embassy of Afghanistan          |
      | /register-a-birth/y/venezuela/mother/yes/same_country          | venezuela.consulate@fco.gov.uk  |
      | /register-a-death/y/overseas/north-korea/same_country          | Pyongyang.enquiries@fco.gov.uk  |
      | /report-a-lost-or-stolen-passport/y/abroad/afghanistan         | britishembassy.kabul@fco.gov.uk |

  @normal
  Scenario Outline: Postcode lookup
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                                                              | Expected string            |
      | /benefit-cap-calculator/y/yes/no/none/bereavement/1000.0/1000.0/single/SW1A%202AA | Greater London benefit cap |
      | /benefit-cap-calculator/y/yes/no/none/bereavement/1000.0/1000.0/single/EH99%201SP | Outside London benefit cap |
      | /landlord-immigration-check/y/SW1A%202AA                                          | Is the person renting      |
      | /landlord-immigration-check/y/EH99%201SP                                          | check in England           |

  @normal
  Scenario: Excluding personal information
    When I visit "/marriage-abroad/y"
    Then I should see that postcodes are stripped from analytics data

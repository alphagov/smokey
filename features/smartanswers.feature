Feature: Smart Answers

  @normal
  Scenario: Check selected smart answer start pages
    Given I am testing through the full stack
    And I force a varnish cache miss
    Then I should be able to visit:
    | Path                                        |
    | /additional-commodity-code                  |
    | /calculate-employee-redundancy-pay          |
    | /calculate-married-couples-allowance        |
    | /marriage-abroad                            |
    | /pay-leave-for-parents                      |
    | /register-a-death                           |
    | /vat-payment-deadlines                      |
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

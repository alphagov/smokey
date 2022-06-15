@app-smartanswers @replatforming
Feature: Smart Answers

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary pages)
  #
  # Data transfer with Content Store is already implicitly
  # covered by "Check stepping through a smart answer".
  #
  # Although individual Smart Answers can't be tested in app,
  # neither should all of them be tested here; testing some of
  # them here only serves to make the test approach unclear.
  #
  Scenario Outline: Check selected smart answer start pages
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                        | Expected string                                      |
      | /additional-commodity-code/y                | How much starch or glucose does the product contain? |
      | /calculate-employee-redundancy-pay/y        | What date was your employee made redundant?          |
      | /calculate-married-couples-allowance/y      | Were you or your partner born before 6 April 1935?   |
      | /marriage-abroad/y                          | Where do you want to get married?                    |
      | /maternity-paternity-pay-leave/y            | Will the mother care for the child with a partner?   |
      | /register-a-death/y                         | Where did the death happen?                          |
      | /vat-payment-deadlines/y                    | When does your VAT accounting period end?            |

  Scenario: Check stepping through a smart answer
    Then I should be able to visit:
    | Path                                        |
    | /vat-payment-deadlines                      |
    | /vat-payment-deadlines/y                    |
    | /vat-payment-deadlines/y/2000-01-31         |
    | /vat-payment-deadlines/y/2000-01-31/cheque  |

  # TODO: RENAME this test to clarify it does not use the
  # Worldwide API (outcomes are "flattened" pre-merge [^1]).
  #
  # [^1]: https://github.com/alphagov/smart-answers/blob/main/app/flows/marriage_abroad_flow/outcomes/countries/sweden/uk/partner_other/_same_sex.erb
  #
  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary pages)
  #
  # This scenario is functionally the same as the one above to
  # "Check stepping through a smart answer".
  #
  Scenario: Check stepping through a smart answer that uses the Worldwide API
    Then I should be able to visit:
    | Path                                                |
    | /marriage-abroad                                    |
    | /marriage-abroad/y                                  |
    | /marriage-abroad/y/sweden                           |
    | /marriage-abroad/y/sweden/uk                        |
    | /marriage-abroad/y/sweden/uk/partner_other          |
    | /marriage-abroad/y/sweden/uk/partner_other/same_sex |

  # TODO: RENAME to clarify this is testing data transfer with
  # Worldwide API.
  #
  # TODO: REMOVE the following examples.
  #
  # - /help-if-you-are-arrested-abroad/y
  # - /marriage-abroad/y
  # - /register-a-birth/y
  # - /register-a-birth/y/afghanistan/father/yes/another_country
  # - /register-a-death/y/overseas
  # - /register-a-death/y/overseas/afghanistan/another_country
  # - /uk-benefits-abroad/y/going_abroad/jsa
  #
  # The above examples do not meet the eligibility criteria in
  # docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary pages)
  #
  # Although individual Smart Answers can't be tested in app,
  # neither should all of them be tested here; testing some of
  # them here only serves to make the test approach unclear.
  #
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
      | /uk-benefits-abroad/y/going_abroad/jsa                     |

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not a critical feature)
  #
  # Data transfer with Content Store and Worldwide API is already
  # covered by e.g. "Check viewing countries in a select element".
  # Country formatting is not a critical feature to GOV.UK. Names
  # in the API are also contract tested [^1].
  #
  # [^1]: https://github.com/alphagov/gds-api-adapters/blob/deb0b31f865445ffbbe23b6b254264c573542a43/test/whitehall_api/worldwide_api_pact_test.rb#L27
  #
  Scenario Outline: Check country names are correctly formatted
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                                                         | Expected string                                    |
      | /marriage-abroad/y/netherlands/ceremony_country/partner_british/opposite_sex | local authorities in the Netherlands               |
      | /marriage-abroad/y/cayman-islands/uk/partner_british/opposite_sex            | The Cayman Islands is a British overseas territory |
      | /register-a-birth/y/cayman-islands                                           | regulations in the Cayman Islands                  |
      | /register-a-death/y/overseas/cayman-islands                                  | regulations in the Cayman Islands                  |

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not a critical feature)
  #
  # Data transfer with Content Store and Worldwide API is already
  # covered by e.g. "Check viewing countries in a select element".
  # Country validation is not a critical feature to GOV.UK. Slugs
  # in the API are contract tested [^1]. Validation is also tested
  # in app [^2].
  #
  # [^1]: https://github.com/alphagov/gds-api-adapters/blob/main/test/whitehall_api/worldwide_api_pact_test.rb#L73
  # [^2]: https://github.com/alphagov/gds-api-adapters/blob/deb0b31f865445ffbbe23b6b254264c573542a43/test/whitehall_api/worldwide_api_pact_test.rb#L33
  #
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

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not a critical feature)
  #
  # Data transfer with Content Store and Worldwide API is already
  # covered by e.g. "Check viewing countries in a select element".
  #
  # This test is checking another endpoint of the Worldwide API,
  # which is not a critical feature of GOV.UK as a whole. It is
  # also covered by a contract test [^1] and in app tests [^2].
  #
  # [^1]: https://github.com/alphagov/gds-api-adapters/blob/deb0b31f865445ffbbe23b6b254264c573542a43/test/whitehall_api/worldwide_api_pact_test.rb#L90
  # [^2]: https://github.com/alphagov/smart-answers/blob/052af0b0007ba04d018fc290d7fe105c9f71b55d/test/flows/register_a_death_flow_test.rb#L23  #
  Scenario Outline: Check country FCOs can be looked up
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                                           | Expected string                 |
      | /marriage-abroad/y/afghanistan/uk/partner_british/opposite_sex | Embassy of Afghanistan          |
      | /register-a-death/y/overseas/north-korea/same_country          | British Embassy Pyongyang       |


  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary feature)
  #
  # Data transfer with Content Store is already implicitly covered
  # by "Check stepping through a smart answer".
  #
  # This test checks that stripping is enabled [^1] but not that it
  # actually happens in requests to Google Analytics.
  #
  # Post code stripping is part of a component and tested there [^2].
  # This is just one of many aspects of how we use Google Analytics,
  # including other sanitisation techniques.
  #
  # [^1]: https://github.com/alphagov/smart-answers/blob/a51258e22f61996238fef420e982bd1af9a62a43/app/views/layouts/application.html.erb#L28
  # [^2]: https://github.com/alphagov/govuk_publishing_components/blob/3c82bd742c1ccb0e01db1873b0d4185ca1993bee/spec/javascripts/govuk_publishing_components/analytics/pii.spec.js#L104
  #
  Scenario: Check personal information is excluded from analytics data
    When I visit "/marriage-abroad/y"
    Then I should see that postcodes are stripped from analytics data

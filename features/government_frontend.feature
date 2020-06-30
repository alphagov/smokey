@aws
Feature: Government Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

    Scenario Outline: Check example pages across formats
      When I request "<Path>"
      Then I should get a 200 status code

      Examples:
        | Path                                                                                                  |
        | /government/case-studies/out-of-syria-back-into-school                                                |
        | /foreign-travel-advice/belgium                                                                        |
        | /self-assessment-tax-returns                                                                          |
        | /government/speeches/the-failure-of-child-protection-and-the-need-for-a-fresh-start                   |
        | /government/fatalities/lieutenant-antony-king                                                         |
        | /government/news/relationships-and-sex-education-for-the-21st-century                                 |
        | /government/get-involved/take-part/help-run-a-charity                                                 |
        | /government/world-location-news/farewell-party-for-the-british-honorary-consul-in-galapagos.es-419    |
        | /government/publications/belarus-tax-treaties                                                         |
        | /government/publications/budget-2016-documents/budget-2016                                            |
        | /government/consultations/red-diesel-call-for-evidence                                                |
        | /government/collections/fraud-error-debt-and-grants-function                                          |
        | /government/statistics/announcements/nhs-outcomes-framework-indicators-aug-2018-release               |
        | /government/topical-events/2014-overseas-territories-joint-ministerial-council/about                  |
        | /government/groups/nuclear-energy-skills-alliance                                                     |
        | /aaib-reports/beech-f33a-g-hope-14-july-1989                                                          |
        | /guidance/introduction-of-statutory-participation-in-trialling-of-national-curriculum-tests-from-2016 |
        | /cma-cases/agc-automotive-europe-nordglass                                                            |
        | /countryside-stewardship-grants/relocation-of-sheep-dips-and-pens-rp20                                |
        | /drug-safety-update/paraffin-based-treatments-risk-of-fire-hazard                                     |
        | /maib-reports/switchboard-fire-on-ferry-off-larne-northern-ireland                                    |
        | /drug-device-alerts/medical-device-alerts-archived-in-july-2015                                       |
        | /raib-reports/collision-with-a-collapsed-signal-post-at-newbury                                       |
        | /business-finance-support/better-business-finance                                                     |
        | /workplace-temperatures                                                                               |
        | /help/update-email-notifications                                                                      |
        | /government/statistical-data-sets/effort-statistics-february-2017                                     |
        | /government/publications/development-scheme/practice-guide-72-development-schemes                     |

  Scenario: Check service sign-in offers both Government Gateway and GOV.UK Verify
    When I visit "/log-in-file-self-assessment-tax-return/sign-in/prove-identity"
    Then I should see "How do you want to sign in?"
    And I should see a radio button for "sign-in-with-government-gateway"
    And I should see a radio button for "sign-in-with-gov-uk-verify"
    And I should see a radio button for "register-for-self-assessment"
    And I should see a continue button

  @pending
  Scenario: Check service sign-in redirects correctly to Government Gateway
    When I visit "/log-in-file-self-assessment-tax-return/sign-in/prove-identity"
    When I choose "Sign in with Government Gateway"
    Then I should be redirected to "https://www.tax.service.gov.uk/gg/sign-in?continue=/account"

  @pending
  Scenario: Check service sign-in redirects correctly to GOV.UK Verify
    When I visit "/log-in-file-self-assessment-tax-return/sign-in/prove-identity"
    When I choose "Sign in with GOV.UK Verify"
    Then I should be redirected to "https://www.signin.service.gov.uk/start"

  Scenario: Check service sign-in redirects correctly to registration page
    When I visit "/log-in-file-self-assessment-tax-return/sign-in/prove-identity"
    When I choose "Register for Self Assessment"
    Then I should be redirected to "/log-in-file-self-assessment-tax-return/sign-in/register-self-assessment"

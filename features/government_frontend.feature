@app-government-frontend @replatforming
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
      | /government/get-involved                                                                              |

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
    Then I should be redirected to "/register-for-self-assessment"

  Scenario: Ensure the Get Involved page loads
    When I request "/government/get-involved"
    Then I should get a 200 status code

  Scenario: Ensure static content is rendered
    When I visit "/government/get-involved"
    Then I should see "Get involved"
    And I should see "Find out how you can engage with government directly, and take part locally, nationally or internationally."

  Scenario Outline: Ensure internal static links are correct
    When I visit "/government/get-involved"
    And I click on the link "<Link>"
    Then I should be at a location path of "<InternalPath>"

    Examples:
      | Link                                        | InternalPath                 |
      | See all government departments              | /government/organisations    |
      | Take part in your local Neighbourhood Watch | /do-something-your-community |

  Scenario Outline: Ensure search links are correct
    When I visit "/government/get-involved"
    Then I should see the search link "<SearchLinkText>"
    And it should link to "<SearchPage>"

    Examples:
      | SearchLinkText           | SearchPage                                                                                                                                          |
      | Search all consultations | /search/policy-papers-and-consultations?content_store_document_type%5B%5D=open_consultations&content_store_document_type%5B%5D=closed_consultations |
      | Open consultations       | /search/policy-papers-and-consultations?content_store_document_type=open_consultations                                                              |
      | Closed consultations     | /search/policy-papers-and-consultations?content_store_document_type=closed_consultations                                                            |

  Scenario: Ensure Next Closing box is populated
    When I visit "/government/get-involved"
    Then I should see the next closing box
    And it should be populated
    When I click the next closing response link
    Then I should see the next closing consultation

  Scenario: Ensure we can see three consultations that were recently opened
    When I visit "/government/get-involved"
    Then I should see "Recently opened"
    And it should be populated with three open consultations

  Scenario: Ensure we can see three recent consultation outcomes
    When I visit "/government/get-involved"
    Then I should see "Recent outcomes"
    And it should be populated with three closed consultations

  Scenario Outline: Ensure the Take Part pages are populated
    When I visit "/government/get-involved"
    Then I should see "Take part"
    And I should see "<Title>"
    When I click on the link "<Title>"
    And I should be at a location path of "<Path>"

    Examples:
      | Title                                                         | Path                                                                                                      |
      | Volunteer                                                     | /government/get-involved/take-part/volunteer                                                              |
      | National Citizen Service                                      | /government/get-involved/take-part/national-citizen-service                                               |
      | Start a public service mutual                                 | /government/get-involved/take-part/start-a-public-service-mutual                                          |
      | Set up a new school                                           | /government/get-involved/take-part/set-up-a-new-school                                                    |
      | Help make your neighbourhood a safer place                    | /government/get-involved/take-part/help-make-your-neighbourhood-a-safer-place                             |
      | Decide where homes, shops and businesses should be built      | /government/get-involved/take-part/decide-where-new-homes-shops-facilities-and-businesses-should-be-built |
      | Challenge to run a local service                              | /government/get-involved/take-part/challenge-to-run-a-local-service                                       |
      | Improve your social housing                                   | /government/get-involved/take-part/improve-your-social-housing                                            |
      | Protect a local building                                      | /government/get-involved/take-part/protect-a-local-building                                               |
      | Organise a street party                                       | /government/get-involved/take-part/organise-a-street-party                                                |
      | Take over a local pub, shop, or green space for the community | /government/get-involved/take-part/take-over-a-local-pub-shop-or-green-space-for-the-community            |
      | Volunteer as a school governor                                | /become-school-college-governor                                                                           |
      | Set up a town or parish council                               | /government/get-involved/take-part/set-up-a-town-or-parish-council                                        |
      | Invest in local enterprises                                   | /government/get-involved/take-part/invest-in-local-enterprises                                            |
      | Help run a charity                                            | /government/get-involved/take-part/help-run-a-charity                                                     |
      | Make a neighbourhood plan                                     | /government/get-involved/take-part/make-a-neighbourhood-plan                                              |
      | Create a community library                                    | /government/get-involved/take-part/create-a-community-library                                             |
      | Become a councillor                                           | /government/get-involved/take-part/become-a-councillor                                                    |

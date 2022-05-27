@app-government-frontend @replatforming
Feature: Government Frontend

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
  # Data transfer with Content Store is already covered by
  # "Ensure static content is rendered".
  #
  # Also tested in app as follows.
  #
  # - /government/case-studies/out-of-syria-back-into-school (case_study_test.rb)
  # - /self-assessment-tax-returns (guide_test.rb)
  # - /government/speeches/the-failure-of-child-protection-and-the-need-for-a-fresh-start (speech_test.rb)
  # - /government/fatalities/lieutenant-antony-king (fatality_notice_test.rb)
  # - /government/news/relationships-and-sex-education-for-the-21st-century (news_article_test.rb)
  # - /government/get-involved/take-part/help-run-a-charity (take_part_test.rb)
  # - /government/world-location-news/farewell-party-for-the-british-honorary-consul-in-galapagos.es-419 (redirect, news_article)
  # - /government/publications/belarus-tax-treaties (publication_test.rb)
  # - /government/publications/budget-2016-documents/budget-2016 (html_publication_test.rb)
  # - /government/consultations/red-diesel-call-for-evidence (consultation_test.rb)
  # - /government/collections/fraud-error-debt-and-grants-function (document_collection-test.rb)
  # - /government/statistics/announcements/nhs-outcomes-framework-indicators-aug-2018-release (redirect, publication)
  # - /government/topical-events/2014-overseas-territories-joint-ministerial-council/about (topical_event_about_page_test.rb)
  # - /government/groups/nuclear-energy-skills-alliance (working_group_test.rb)
  # - /aaib-reports/beech-f33a-g-hope-14-july-1989 (specialist_document_test.rb)
  # - /guidance/introduction-of-statutory-participation-in-trialling-of-national-curriculum-tests-from-2016 (detailed_guide_test.rb)
  # - /cma-cases/agc-automotive-europe-nordglass (specialist_document_test.rb)
  # - /countryside-stewardship-grants/relocation-of-sheep-dips-and-pens-rp20 (specialist_document_test.rb)
  # - /drug-safety-update/paraffin-based-treatments-risk-of-fire-hazard (specialist_document_test.rb)
  # - /maib-reports/switchboard-fire-on-ferry-off-larne-northern-ireland (specialist_document_test.rb)
  # - /drug-device-alerts/medical-device-alerts-archived-in-july-2015 (specialist_document_test.rb)
  # - /raib-reports/collision-with-a-collapsed-signal-post-at-newbury (specialist_document_test.rb)
  # - /business-finance-support/better-business-finance (specialist_document_test.rb)
  # - /workplace-temperatures (answer_test.rb)
  # - /help/update-email-notifications (help_page_test.rb)
  # - /government/statistical-data-sets/effort-statistics-february-2017 (statistical_data_set_test.rb)
  # - /government/publications/development-scheme/practice-guide-72-development-schemes (html_publication_test.rb)
  # - /guidance/content-design/planning-content (manual_section_test.rb)
  # - /hmrc-internal-manuals/pensions-tax-manual (hmrc_manual_test.rb)
  #
  # Also covered by other scenarios as follows.
  #
  # - /foreign-travel-advice/belgium (Check a country page loads correctly)
  # - /government/get-involved (Ensure static content is rendered)
  #
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
      | /guidance/content-design/planning-content  |
      | /hmrc-internal-manuals/pensions-tax-manual |

  # TODO: REMOVE this test as it is a duplicate.
  #
  # Duplicate of "Ensure static content is rendered".
  #
  Scenario: Ensure the Get Involved page loads
    When I request "/government/get-involved"
    Then I should get a 200 status code

  Scenario: Ensure static content is rendered
    When I visit "/government/get-involved"
    Then I should see "Get involved"
    And I should see "Find out how you can engage with government directly, and take part locally, nationally or internationally."

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # Data transfer with Content Store is already covered by
  # "Ensure static content is rendered".
  #
  # This test is checking two hardcoded links [^1][^2]. We do
  # not need to test all declarative HTML.
  #
  # This test also fails frequently due to the unconventional
  # test approach of actually clicking the links [^3].
  #
  # [^1]: https://github.com/alphagov/government-frontend/blob/main/app/views/content_items/get_involved.html.erb#L148
  # [^2]: https://github.com/alphagov/government-frontend/blob/main/app/views/content_items/get_involved.html.erb#L221
  # [^3]: https://github.com/alphagov/smokey/issues/950
  #
  Scenario Outline: Ensure internal static links are correct
    When I visit "/government/get-involved"
    And I click on the link "<Link>"
    Then I should be at a location path of "<InternalPath>"

    Examples:
      | Link                                        | InternalPath                 |
      | See all government departments              | /government/organisations    |
      | Take part in your local Neighbourhood Watch | /do-something-your-community |

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # Data transfer with Content Store is already covered by
  # "Ensure static content is rendered". These links are not a
  # critical feature of GOV.UK.
  #
  # Should be tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/government-frontend/blob/main/app/helpers/get_involved_helper.rb
  #
  Scenario Outline: Ensure search links are correct
    When I visit "/government/get-involved"
    Then I should see the search link "<SearchLinkText>"
    And it should link to "<SearchPage>"

    Examples:
      | SearchLinkText           | SearchPage                                                                                                                                          |
      | Search all consultations | /search/policy-papers-and-consultations?content_store_document_type%5B%5D=open_consultations&content_store_document_type%5B%5D=closed_consultations |
      | Open consultations       | /search/policy-papers-and-consultations?content_store_document_type=open_consultations                                                              |
      | Closed consultations     | /search/policy-papers-and-consultations?content_store_document_type=closed_consultations                                                            |

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # Data transfer with Search API is already covered by
  # "Ensure we can see three consultations that were recently opened".
  #
  # Should be tested in app [^1], but only partially tested [^2].
  #
  # [^1]: https://github.com/alphagov/government-frontend/blob/5f0256bd85347d5bba0d130aa986fc643e001f57/app/views/content_items/get_involved.html.erb#L73-L86
  # [^2]: https://github.com/alphagov/government-frontend/blob/5f0256bd85347d5bba0d130aa986fc643e001f57/test/controllers/get_involved_controller_test.rb
  #
  Scenario: Ensure Next Closing box is populated
    When I visit "/government/get-involved"
    Then I should see the next closing box
    And it should be populated
    When I click the next closing response link
    Then I should see the next closing consultation

  # TODO: RENAME to clarify this is testing data transfer with
  # Search API (as the prime example for this app).
  #
  Scenario: Ensure we can see three consultations that were recently opened
    When I visit "/government/get-involved"
    Then I should see "Recently opened"
    And it should be populated with three open consultations

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # Data transfer with Search API is already covered by
  # "Ensure we can see three consultations that were recently opened".
  #
  # Should be tested in app [^1], but only partially tested [^2].
  #
  # [^1]: https://github.com/alphagov/government-frontend/blob/5f0256bd85347d5bba0d130aa986fc643e001f57/app/views/content_items/get_involved.html.erb#L105-L122
  # [^2]: https://github.com/alphagov/government-frontend/blob/5f0256bd85347d5bba0d130aa986fc643e001f57/test/controllers/get_involved_controller_test.rb
  #
  Scenario: Ensure we can see three recent consultation outcomes
    When I visit "/government/get-involved"
    Then I should see "Recent outcomes"
    And it should be populated with three closed consultations

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # Data transfer with Content Store is already covered by
  # "Ensure static content is rendered".
  #
  # This test also fails frequently due to the unconventional
  # test approach of actually clicking the links [^1].
  #
  # Should be tested in app [^2].
  #
  # [^1]: https://github.com/alphagov/smokey/issues/950
  # [^2]: https://github.com/alphagov/government-frontend/blob/5f0256bd85347d5bba0d130aa986fc643e001f57/app/controllers/get_involved_controller.rb#L29
  #
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

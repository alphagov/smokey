@app-government-frontend @replatforming
Feature: Government Frontend

  Scenario: Ensure static content is rendered
    When I visit "/government/get-involved"
    Then I should see "Get involved"
    And I should see "Find out how you can engage with government directly, and take part locally, nationally or internationally."

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

  Scenario: Check the frontend can talk to Search API
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

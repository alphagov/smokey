@app-collections @replatforming
Feature: Collections

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
  # "Check mainstream browse page loads with links".
  #
  # Also tested in app, as follows.
  #
  # - /government/organisations (content_store_organisations_spec.rb)
  # - /government/organisations/hm-revenue-customs (organisation_spec.rb)
  # - /government/organisations/ministry-of-justice.cy (organisation_spec.rb)
  # - /browse/births-deaths-marriages/register-offices (mainstream_browsing_spec.rb)
  # - /health-and-social-care/childrens-health (taxon_browsing_spec.rb)
  # - /international/living-abroad (taxon_browsing_spec.rb)
  # - /learn-to-drive-a-car (step_nav_page_spec.rb)
  # - /society-and-culture/poverty-and-social-justice (taxon_browsing_spec.rb)
  # - /welfare (taxon_browsing_spec.rb)
  # - /world/armenia (world_wide_taxon_browsing_spec.rb)
  #
  Scenario Outline: Check example collection pages
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                             | Expected string                                           |
      | /government/organisations                        | Departments, agencies and public bodies                   |
      | /government/organisations/hm-revenue-customs     | HM Revenue &amp; Customs                                  |
      | /government/organisations/ministry-of-justice.cy | Gweinyddiaeth Cyfiawnder                                  |
      | /browse/births-deaths-marriages/register-offices | Certificates, register offices, changes of name or gender |
      | /health-and-social-care/childrens-health         | Children's health                                         |
      | /international/living-abroad                     | Living abroad                                             |
      | /learn-to-drive-a-car                            | Learn to drive a car: step by step                        |
      | /society-and-culture/poverty-and-social-justice  | Poverty and social justice                                |
      | /welfare                                         | Welfare                                                   |
      | /world/armenia                                   | UK help and services in Armenia                           |

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (no content tested)
  #
  # Data transfer with Content Store is already covered by
  # "Check mainstream browse page loads with links".
  #
  # The step doesn't actually check any content on the page and
  # CSS changes mean it no longer finds any links to click i.e.
  # the scenario is broken. Collections has a basic test that the
  # page loads [^1], which is functionally the same as this.
  #
  # [^1]: https://github.com/alphagov/collections/blob/main/spec/controllers/browse_controller_spec.rb#L4
  #
  Scenario: Check mainstream browse index page loads correctly
    When I visit "/browse"
    Then I should be able to navigate the browse pages

  # TODO: RENAME to clarify this is testing data transfer
  # with Content Store (as the prime example for the app).
  #
  Scenario: Check mainstream browse page loads with links
    When I visit "/browse/driving"
    And I should see "Teaching people to drive"
    When I click on the section "Teaching people to drive"
    Then I should see "Apply to become a driving instructor"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (no content tested)
  #
  # Data transfer with Content Store is already covered by
  # "Check mainstream browse page loads with links".
  #
  # The step doesn't actually check any content on the page and
  # CSS changes mean it no longer finds any links to click i.e.
  # the scenario is broken. Also tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/collections/blob/main/spec/features/topic_browsing_spec.rb
  #
  Scenario: Check topic page loads correctly
    When I visit "/topic"
    Then I should be able to navigate the topic hierarchy

  # TODO: RENAME to clarify this is testing data transfer with
  # Search API.
  #
  Scenario: Check services and information page loads correctly
    When I visit "/government/organisations/hm-revenue-customs/services-information"
    Then I see links to pages per topic

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (no content tested)
  #
  # Data transfer with Search API is already covered by
  # "Check services and information page loads correctly".
  #
  # Also tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/collections/blob/31ff3c5e5eac08af97369343446b32227c6d3a78/spec/features/atom_feeds_spec.rb#L42
  #
  Scenario: Check government documents feed JSON format is consistent
    When I request "/government/feed"
    Then valid XML should be returned

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Email Alert API is already covered by
  # "Email signup from a taxon page". Also tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/collections/blob/main/spec/features/organisation_spec.rb#L192
  #
  Scenario: Email signup from an organisation home page
    When I visit "/government/organisations/department-for-education"
    And I click on the link "email"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

  # TODO: RENAME to clarify this is testing data transfer with
  # Email Alert API (as the prime example for the app).
  #
  # Note: this scenario also covers legacy functionality in Email
  # Alert Frontend [^1]. It's easier to make it the prime example
  # than try to justify its removal.
  #
  # [^1]: https://github.com/alphagov/email-alert-frontend/tree/ffaba3f435bcddc8489ac8e3666008dd64ffddf4#signup
  #
  Scenario: Email signup from a taxon page
    When I visit "/education"
    Then I should see "Get emails for this topic"
    When I click on the link "Get emails for this topic"
    Then I should see "What do you want to get emails about?"
    When I choose radio button "Teaching and leadership" and click on "Continue"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with Email Alert API is already covered by
  # "Email signup from a taxon page". Also tested in app [^1].
  #
  # [^1]: https://github.com/alphagov/collections/blob/main/spec/features/world_location_taxon_spec.rb#L26
  #
  Scenario: Email signup from a topic page
    When I visit "/topic/transport/motorways-major-roads"
    Then I should see "Get emails for this topic"
    When I click on the link "Get emails for this topic"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

@app-collections
Feature: Collections

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

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

  Scenario: Check mainstream browse index page loads correctly
    When I visit "/browse"
    Then I should be able to navigate the browse pages

  Scenario: Check mainstream browse page loads with links
    When I visit "/browse/driving"
    And I should see "Teaching people to drive"
    When I click on the section "Teaching people to drive"
    Then I should see "Apply to become a driving instructor"

  Scenario: Check topic page loads correctly
    When I visit "/topic"
    Then I should be able to navigate the topic hierarchy

  Scenario: Check services and information page loads correctly
    When I visit "/government/organisations/hm-revenue-customs/services-information"
    Then I see links to pages per topic

  Scenario: Check government documents feed JSON format is consistent
    When I request "/government/feed"
    Then valid XML should be returned

  Scenario: Email signup from an organisation home page
    When I visit "/government/organisations/department-for-education"
    And I click on the link "email"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

  Scenario: Email signup from a taxon page
    When I visit "/education"
    Then I should see "Get emails about this topic"
    When I click on the link "Get emails about this topic"
    Then I should see "What do you want to get emails about?"
    When I choose radio button "Teaching and leadership" and click on "Continue"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

  Scenario: Email signup from a topic page
    When I visit "/topic/transport/motorways-major-roads"
    Then I should see "Get emails for this topic"
    When I click on the link "Get emails for this topic"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

  @local-network
  Scenario: Healthcheck
    Given I am testing "collections" internally
    When I request "/healthcheck/ready"
    Then JSON is returned
    And I should see ""status":"ok""

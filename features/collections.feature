Feature: Collections

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario Outline: Check example collection pages
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                                             | Expected string                                           |
      | /government/organisations                        | Departments, agencies and public bodies                   |
      | /government/organisations/hm-revenue-customs     | HM Revenue &amp; Customs                                  |
      | /browse/births-deaths-marriages/register-offices | Certificates, register offices, changes of name or gender |
      | /health-and-social-care/childrens-health         | Children's health                                         |
      | /international/living-abroad                     | Living abroad                                             |
      | /society-and-culture/poverty-and-social-justice  | Poverty and social justice                                |
      | /welfare                                         | Welfare                                                   |

  @high
  Scenario: Check mainstream browse index page loads
    When I visit "/browse"
    Then I should be able to navigate the browse pages

  @normal
  Scenario: Check mainstream browse page loads with links
    When I visit "/browse/driving"
    And I should see "Teaching people to drive"
    When I click on the section "Teaching people to drive"
    Then I should see "Apply to become a driving instructor"

  @normal
  Scenario: Check services and information page loads
    When I visit "/government/organisations/hm-revenue-customs/services-information"
    Then I see links to pages per topic

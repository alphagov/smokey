Feature: Collections

  @normal
  Scenario Outline: Check example collection pages
    Given I am testing through the full stack
    And I force a varnish cache miss
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

  @normal
  Scenario: Check services and information pages
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/organisations/hm-revenue-customs/services-information"
    Then I see links to pages per topic

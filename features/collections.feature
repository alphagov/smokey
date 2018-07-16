Feature: Collections

  @normal
  Scenario Outline: Check example collection pages
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I request "<Path>"
    Then I should get a 200 status code

    Examples:
      | Path                                                            |
      | /browse/births-deaths-marriages/register-offices                |
      | /health-and-social-care/childrens-health                        |
      | /international/living-abroad                                    |
      | /society-and-culture/poverty-and-social-justice                 |
      | /welfare                                                        |

  @normal
  Scenario: Check services and information pages
    Given I am testing through the full stack
    And I force a varnish cache miss
    When I visit "/government/organisations/hm-revenue-customs/services-information"
    Then I see links to pages per topic

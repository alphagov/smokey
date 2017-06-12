Feature: Collections for Worldwide Taxonomy

  Scenario: Using the accordion page
    When I visit "/world/brazil"

    Then I should be able to see the following accordion sections:
      | Living abroad                              |
      | Tax, benefits, pensions and working abroad |
      | Coming to the UK                           |
      | Travelling to Brazil                       |
      | Trade and invest in the UK                 |
      | Diplomacy and development                  |
      | British Embassy or High Commission         |

    And I cannot see any of the accordion content

    When I toggle the first accordion section
    Then I can see the accordion content for only the first item

    When I toggle the first accordion section
    Then I cannot see the accordion content for only the first item

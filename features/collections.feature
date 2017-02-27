Feature: Collections

  @notstaging @notproduction
  Scenario: Using the accordion page
    Given I am in the "B" group for "EducationNavigation" AB testing
    When I visit "/education/special-educational-needs-and-disability-send-and-high-needs"
    Then I can see an accordion
    And I cannot see any of the accordion content

    When I toggle the first accordion section
    Then I can see the accordion content for only the first item

    When I toggle the first accordion section
    Then I cannot see the accordion content for only the first item

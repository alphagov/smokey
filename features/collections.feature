Feature: Collections

  @notintegration @notstaging
  Scenario: Automatic opt-in to the B variant from navigation pages without any
    previous variant
    Given I do not have any AB testing cookies set
    And I am testing through the full stack
    When I visit "/education"
    Then I am in the "B" variant of the education navigation test
    And I stay on bucket "B" of the education navigation test when I keep visiting "/education"

  @notintegration @notstaging
  Scenario: Don't automatically opt-in to B variant on content pages
    that start with "education"
    Given I am testing through the full stack
    And I am in the "A" group for "EducationNavigation" AB testing
    When I visit "/education-maintenance-allowance-ema"
    Then I am in the "A" variant of the education navigation test
    And I stay on bucket "A" of the education navigation test when I keep visiting "/education-maintenance-allowance-ema"

  Scenario: Using the accordion page
    Given I am in the "B" group for "EducationNavigation" AB testing
    When I visit "/education/special-educational-needs-and-disability-send-and-high-needs"
    Then I can see an accordion
    And I cannot see any of the accordion content

    When I toggle the first accordion section
    Then I can see the accordion content for only the first item

    When I toggle the first accordion section
    Then I cannot see the accordion content for only the first item

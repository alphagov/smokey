Feature: Get Ready for Brexit Check

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Brexit checker shows results
    When I start the checker
    And I answer the nationality question
    And I answer the where do you live question
    And I skip all other questions
    Then I should see the results page
    And I should see confirmation of my answers
    And I should see answers applicable to me

  Scenario: Check that the Brexit checker can be subscribed to
    When I visit "/transition-check/questions"
    And I answer the nationality question
    And I skip all other questions
    And I click Subscribe link
    And I click Subscribe button
    Then I should enter the email subscription workflow

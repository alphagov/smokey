Feature: Email Signup Journeys
  There are multiple different ways a user can start their email subscription
  signup journey

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @high
  Scenario: Starting from foreign travel advise
    When I visit "/foreign-travel-advice/turkey"
    And I click on the link "Get email alerts"
    Then I should see "Create subscription"
    When I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"
    When I choose radio button "No more than once a week" and click on "Next"
    And I input "simulate-delivered@notifications.service.gov.uk" and click subscribe
    Then I should see "You’ve subscribed successfully"

  @normal
  Scenario: Starting from organisations
    When I visit "/government/organisations/department-for-education"
    And I click on the link "email"
    Then I should see "Create subscription"
    When I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from a finder
    When I visit "/government/policies/immigration-and-borders"
    And I click on the link "Subscribe to email alerts"
    Then I should see "Create subscription"
    When I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from announcements
    When I visit "/government/announcements"
    And I click on the link "email"
    Then I should see "Email alert subscription"
    When I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from whitehall finder
    When I visit "/government/publications"
    And I click on the link "email"
    Then I should see "Create subscription"
    When I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from a taxon page
    When I visit "/education"
    Then I should see "Get email alerts for this topic"
    When I click on the link "Get email alerts for this topic Education, training and skills"
    Then I should see "What do you want to get alerts about?"
    When I choose radio button "Teaching and leadership" and click on "Select"
    And I click on the button "Sign up now"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from a topic page
    When I visit "/topic/transport/motorways-major-roads"
    Then I should see "Subscribe to email alerts"
    When I click on the link "Subscribe to email alerts"
    And I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from a finder(specialist publisher)
    When I visit "/cma-cases"
    Then I should see "Subscribe to email alerts"
    When I click on the link "Subscribe to email alerts"
    And I choose the checkbox "Markets" and click on "Create subscription"
    Then I should see "How often do you want to get updates?"

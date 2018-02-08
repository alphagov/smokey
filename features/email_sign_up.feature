Feature: Email Signup Journeys
  There are multiple different ways a user can start their email subscription
  signup journey

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @high
  Scenario: Starting from foreign travel advise
    When I visit "/foreign-travel-advice/turkey"
    Then I should see "Get email alerts"
    When I click "Get email alerts"
    Then I should see a create subscription button
    When I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"
    When I choose radio button "No more than once a week" and click on "Next"
    And I input "email@email.com" and click subscribe
    Then I should see "Subscribed successfully"

  @normal
  Scenario: Starting from organisations
    When I visit "/government/organisations/department-for-education"
    Then I should see "email"
    And I click "email"
    Then I should see a create subscription button
    When I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from a finder
    When I visit "/government/policies/immigration-and-borders"
    And I click "Subscribe to email alerts"
    Then I should see a create subscription button
    When I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from announcements
    When I visit "/government/announcements"
    And I click "email"
    Then I should see a create subscription button
    When I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from whitehall finder
    When I visit "/government/publications"
    And I click "email"
    Then I should see a create subscription button
    When I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from a taxon page
    When I visit "/education"
    Then I should see "Get email alerts for this topic"
    When I click on the link with path "/email-signup/?topic=/education"
    Then I should see "What do you want to get alerts about?"
    When I choose radio button "Teaching and leadership" and click on "Select"
    And I click on the button "Sign up now"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from a topic page
    When I visit "/topic/transport/motorways-major-roads"
    Then I should see "Subscribe to email alerts"
    When I click on the link with path "/topic/transport/motorways-major-roads/email-signup"
    And I click on the button "Create subscription"
    Then I should see "How often do you want to get updates?"

  @normal
  Scenario: Starting from a finder(specialist publisher)
    When I visit "/cma-cases"
    Then I should see "Subscribe to email alerts"
    When I click "Subscribe to email alerts"
    And I choose the checkbox "Markets" and click on "Create subscription"
    Then I should see "How often do you want to get updates?"

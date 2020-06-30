Feature: Email signup
  Tests for each of the email signup journeys to ensure they lead to the right
  place.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Starting from foreign travel advice
    When I visit "/foreign-travel-advice/turkey"
    And I click on the link "Get email alerts"
    Then I should see "Create subscription"
    When I click on the button "Create subscription"
    Then I should see "How often do you want to receive emails?"

  Scenario: Starting from an organisation home page
    When I visit "/government/organisations/department-for-education"
    And I click on the link "email"
    Then I should see "Sign up to get emails"
    When I click on the button "Sign up"
    Then I should see "How often do you want to receive emails?"

  Scenario: Starting from the news and communications finder
    When I visit "/search/news-and-communications"
    And I click on the link "Get email alerts"
    Then I should see "Email alert subscription"
    When I click on the button "Create subscription"
    Then I should see "How often do you want to receive emails?"

  Scenario: Starting from the statistics finder
    When I visit "/search/research-and-statistics"
    And I click on the link "Get email alerts"
    Then I should see "Create subscription"
    And I choose the checkbox "Statistics (published)" and click on "Create subscription"
    Then I should see "How often do you want to receive emails?"

  Scenario: Starting from a taxon page
    When I visit "/education"
    Then I should see "Sign up for updates to this topic page"
    When I click on the link "Sign up for updates to this topic page"
    Then I should see "What do you want to get alerts about?"
    When I choose radio button "Teaching and leadership" and click on "Select"
    And I click on the button "Sign up"
    Then I should see "How often do you want to receive emails?"

  Scenario: Starting from a topic page
    When I visit "/topic/transport/motorways-major-roads"
    Then I should see "Subscribe to email alerts"
    When I click on the link "Subscribe to email alerts"
    And I click on the button "Sign up"
    Then I should see "How often do you want to receive emails?"

  Scenario: Starting from a finder (specialist-publisher)
    When I visit "/cma-cases"
    Then I should see "Get email alerts"
    When I click on the link "Get email alerts"
    And I choose the checkbox "Markets" and click on "Create subscription"
    Then I should see "How often do you want to receive emails?"

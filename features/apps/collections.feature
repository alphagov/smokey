@app-collections @replatforming
Feature: Collections

  Scenario: Check the frontend can talk to Content Store
    When I visit "/browse/driving"
    And I should see "Teaching people to drive"
    And I click on the section "Teaching people to drive"
    Then I should see "Apply to become a driving instructor"

  Scenario: Check the frontend can talk to Search API
    When I visit "/government/organisations/hm-revenue-customs/services-information"
    Then I see links to pages per topic

  Scenario: Check the frontend can talk to Email Alert API
    When I visit "/education"
    Then I should see "Get emails for this topic"
    When I click on the link "Get emails for this topic"
    Then I should see "What do you want to get emails about?"
    When I choose radio button "Teaching and leadership" and click on "Continue"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

  Scenario: Check the feedback component loads
    When I visit "/government/organisations"
    And I confirm it is rendered by "collections"
    And I click to report a problem with the page
    Then I see the report a problem form
    When I close the open feedback form
    And I click to say the page is not useful
    Then I see the email survey signup form
    When I close the open feedback form
    And I click to say the page is useful
    Then I see the feedback confirmation message

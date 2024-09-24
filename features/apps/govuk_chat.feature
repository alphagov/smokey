@app-govuk-chat
Feature: GOV.UK Chat
  Scenario: Can view a static page
    When I visit the GOV.UK Chat about page
    Then I should see "About GOV.UK Chat"

  Scenario: Can log in to chat admin
    Given I am testing "chat"
    When I visit "/admin"
    And I try to login as a user
    And I visit "/admin"
    Then I should see "GOV.UK Chat Admin"

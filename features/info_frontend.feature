@app-info-frontend
Feature: Info Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Check the info page for a GOV.UK page
    When I visit "/info/complain-company"
    Then I should see "Complain about a limited company"
     And I should see "Why is this page on GOV.UK?"

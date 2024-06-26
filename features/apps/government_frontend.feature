@app-government-frontend
Feature: Government Frontend

  @worksonmirror
  Scenario: Check the frontend can talk to Content Store
    When I visit "/government/get-involved"
    Then I should see "Get involved"
    And I should see "Find out how you can engage with government directly, and take part locally, nationally or internationally."

  @app-authenticating-proxy
  Scenario: Check the frontend can talk to draft Content Store
    Given I am testing "draft-origin"
    When I try to login as a user
    When I attempt to visit "government/case-studies/primary-authority-helps-acorn-safeguard-its-business-reputation"
    Then I should see "Case study"
    And the page should contain the draft watermark

  @app-email-alert-frontend
  Scenario: Check the frontend can talk to Email Alert API
    When I visit "/foreign-travel-advice/turkey"
    And I click on the link "Get email alerts"
    And I click on the button "Continue"
    Then I should see "How often do you want to get emails?"

  @worksonmirror
  Scenario: Check the frontend can talk to Search API
    When I visit "/government/get-involved"
    Then I should see "Recently opened"
    And it should be populated with three open consultations

  @worksonmirror
  Scenario: Check a travel advice country page loads
    When I visit "/foreign-travel-advice/luxembourg"
    Then I should see "Luxembourg"
    And I should see "Warnings and insurance"

  @worksonmirror
  Scenario: Check that Service Manuals load
    When I visit "/service-manual"
    Then I should see "Service Manual"

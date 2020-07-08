Feature: Draft environment
  Tests for the draft environment, which is used to preview content before it is
  put live on GOV.UK. Accessing the draft environment requires a valid signon
  session. Access to the draft stack should be denied without a valid signon
  session.

  @draft
  Scenario: Check visiting a draft page requires a signon session
    When I attempt to go to a case study
    Then I should be prompted to log in
    When I log in using valid credentials
    Then I should be on the case study page
    And the page should contain the draft watermark

  @draft
  Scenario: Check visiting a page served by government-frontend
    When I try to login as a user
    When I attempt to visit "government/case-studies/example-case-studies-eu-citizens-rights-in-the-uk"
    Then I should see "Case study"
    And the page should contain the draft watermark

  @draft
  Scenario: Check visiting a specialist document served by government-frontend
    When I try to login as a user
    And I attempt to visit a CMA case
    Then I should see "Competition and Markets Authority"
    And the page should contain the draft watermark

  @draft
  Scenario: Check visiting a manual served by manuals-frontend
    When I try to login as a user
    And I attempt to visit a manual
    Then I should see "Content design"
    And I should see "Search this manual"
    And the page should contain the draft watermark

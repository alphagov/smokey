Feature: Draft environment
  The draft environment is used to preview content before it is put live on
  GOV.UK. Accessing the draft environment requires a valid signon session.
  Access to the draft stack should be denied without a valid signon session.

  @draft @high
  Scenario: visiting a draft page requires a signon session
    When I attempt to go to a case study
    Then I should be prompted to log in
    When I log in using valid credentials
    Then I should be on the case study page
    And the page should contain the draft watermark

  @draft
  Scenario: visiting a page served by government-frontend
    When I try to login as a user
    When I attempt to visit "government/case-studies/epic-cic"
    Then I should see "Case study"
    And the page should contain the draft watermark

  @draft
  Scenario: visiting a page served by contacts-frontend
    When I try to login as a user
    When I attempt to visit "government/organisations/hm-revenue-customs/contact/child-benefit"
    Then I should see "Child Benefit"

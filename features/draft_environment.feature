@app-authenticating-proxy @replatforming
Feature: Draft environment
  Tests for the draft environment, which is used to preview content before it is
  put live on GOV.UK. Accessing the draft environment requires a valid signon
  session. Access to the draft stack should be denied without a valid signon
  session.

  Background:
    Given I am testing "draft-origin"

  Scenario: Check visiting a draft page requires a signon session
    When I attempt to go to a case study
    Then I should be prompted to log in
    When I log in using valid credentials
    Then I should be on the case study page
    And the page should contain the draft watermark

  @app-government-frontend
  Scenario: Check visiting a page served by government-frontend
    Given I force a varnish cache miss
    When I try to login as a user
    When I attempt to visit "government/case-studies/example-case-studies-eu-citizens-rights-in-the-uk"
    Then I should see "Case study"
    And the page should contain the draft watermark

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (already covered)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with the draft Content Store and site-wide
  # Varnish config (authentication) is already covered by
  # "Check visiting a draft page requires a signon session".
  #
  @app-government-frontend
  Scenario: Check visiting a specialist document served by government-frontend
    Given I force a varnish cache miss
    When I try to login as a user
    And I attempt to visit a CMA case
    Then I should see "Competition and Markets Authority"
    And the page should contain the draft watermark

  # TODO: REMOVE this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (already covered)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (arbitrary page)
  #
  # Data transfer with the draft Content Store and site-wide
  # Varnish config (authentication) is already covered by
  # "Check visiting a draft page requires a signon session"
  # and "Check visiting a page served by government-frontend".
  #
  @app-government-frontend
  Scenario: Check visiting a manual served by government-frontend
    Given I force a varnish cache miss
    When I try to login as a user
    And I attempt to visit a manual
    Then I should see "Content design"
    And I should see "Search this manual"
    And the page should contain the draft watermark

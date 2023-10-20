Feature: Origin
  @local-network
  Scenario: Check that the WAF is working
    Given I set header X-Always-Block to true
    When I send a GET request to "/robots.txt"
    Then I should get a 403 status code

  @replatforming
  Scenario: Check robots.txt loads
    When I request "/robots.txt"
    Then I should see "User-agent:"

  @replatforming
  Scenario: Check redirects work
    When I visit "/workplacepensions"
    Then I should be at a location path of "/workplace-pensions"

  @replatforming
  Scenario: Check 404 page loads
    When I visit a non-existent page
    Then I should see "Page not found"

  @replatforming
  Scenario: Check pages are rendered using UTF-8
    When I request "/"
    Then I should get a "Content-Type" header of "text/html; charset=utf-8"

  @app-authenticating-proxy
  Scenario: Check visiting a draft page requires a signon session
    Given I am testing "draft-origin"
    When I attempt to visit "government/case-studies/primary-authority-helps-acorn-safeguard-its-business-reputation"
    Then I should be prompted to log in
    When I log in using valid credentials
    Then I should be on the case study page
    And the page should contain the draft watermark

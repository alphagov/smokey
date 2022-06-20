@replatforming @app-frontend
Feature: Frontend

  Scenario: Check help page loads
    When I visit "/help"
    Then I should see "Help using GOV.UK"

  Scenario: Check homepage loads
    When I request "/"
    Then I should see "Welcome to GOV.UK"

  Scenario: Check the client can talk to Google Analytics
    When I visit "/"
    And I consent to cookies
    Then the page view should be tracked

  Scenario: Check the frontend can talk to Licensing
    When I visit "/busking-licence"
    Then I should see "Busking licence"
    And I should see an input field for postcode
    When I try to post to "/busking-licence" with "postcode=E20+2ST"
    Then I should see "Busking licence"

  Scenario: Check the frontend can talk to Mapit
    When I visit "/pay-council-tax"
    Then I should see "Pay your Council Tax"
    When I try to post to "/pay-council-tax" with "postcode=WC2B+6SE"
    Then I should see "Camden"

  Scenario: Check the frontend can talk to Elections API
    When I visit "/contact-electoral-registration-office"
    Then I should see "Electoral Registration Office"
    When I visit "/contact-electoral-registration-office?postcode=sw1a+1aa"
    Then I should see "Get help with electoral registration"
    When I visit "/contact-electoral-registration-office?postcode=WV148TU"
    Then I should see "Choose your address"

  Scenario: Check the frontend can talk to Imminence
    When I visit "/ukonline-centre-internet-access-computer-training"
    Then I should see "Online Centres Network"
    When I try to post to "/ukonline-centre-internet-access-computer-training" with "postcode=WC2B+6NH"
    Then I should see "Holborn Library"

  Scenario: Check the travel advice index page loads
    When I visit "/foreign-travel-advice"
    Then I should see "Foreign travel advice"
    And I should see "Afghanistan"
    And I should see "Luxembourg"

  # TODO: EXPORT this test as it does not meet the eligibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (not applicable)
  # - Targets data transfer: N (already covered)
  # - Second critical check: N (not tested in app)
  #
  # This page is rendered by Frontend. Data transfer for this
  # app with Static is already covered by
  # "Check the frontend can talk to Static".
  #
  # Should be tested in Static [^1].
  #
  # [^1]: https://github.com/alphagov/static/blob/9f835b87a3aa6ed867b98b2f4534dd64c9510626/app/views/root/_gem_base.html.erb#L43
  #
  Scenario: Check the crown logo links to GOV.UK homepage
    When I visit "/"
    Then the logo should link to the homepage

  Scenario: Check the feedback component loads
    When I visit "/help"
    And I confirm it is rendered by "frontend"
    And I click to report a problem with the page
    Then I see the report a problem form
    When I close the open feedback form
    And I click to say the page is not useful
    Then I see the email survey signup form
    When I close the open feedback form
    And I click to say the page is useful
    Then I see the feedback confirmation message

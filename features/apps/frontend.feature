@app-frontend
Feature: Frontend

  @worksonmirror
  Scenario: Check help page loads
    When I visit "/help"
    Then I should see "Help using GOV.UK"

  @worksonmirror
  Scenario: Check homepage loads
    When I visit "/"
    Then I should see "Welcome to GOV.UK"

  Scenario: Check the frontend can talk to Licensing
    When I visit "/find-licences/busking-licence"
    Then I should see "Busking licence"
    And I should see an input field for postcode
    When I try to post to "/find-licences/busking-licence" with "postcode=E20+2ST"
    Then I should see "Busking licence"

  @worksonmirror
  Scenario: Check the frontend can talk to Asset Manager with media path
    When I visit "/media/5a7b9f8ced915d4147621960/passport-impact-indicat.csv/preview"
    Then I should see "Passport impact indicators - CSV version"

  Scenario: Check the frontend can talk to Locations API and Local Links Manager API
    When I visit "/pay-council-tax"
    Then I should see "Pay your Council Tax"
    When I try to post to "/pay-council-tax" with "postcode=WC2B+6NH"
    Then I should see "Camden"

  Scenario: Check the frontend can talk to Elections API
    When I visit "/contact-electoral-registration-office"
    Then I should see "Electoral Registration Office"
    When I visit "/contact-electoral-registration-office?postcode=sw1a+1aa"
    Then I should see "Get help with electoral registration"
    When I visit "/contact-electoral-registration-office?postcode=WV148TU"
    Then I should see "Choose your address"

  Scenario: Check the frontend can talk to Places Manager
    When I visit "/ukonline-centre-internet-access-computer-training"
    Then I should see "Online Centres Network"
    When I try to post to "/ukonline-centre-internet-access-computer-training" with "postcode=WC2B+6NH"
    Then I should see "Holborn Library"

  @worksonmirror
  Scenario: Check the travel advice index page loads
    When I visit "/foreign-travel-advice"
    Then I should see "Foreign travel advice"
    And I should see "Afghanistan"
    And I should see "Luxembourg"

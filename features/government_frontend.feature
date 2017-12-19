Feature: Government Frontend

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario:
    When I visit "/government/case-studies/epic-cic"
    Then I should see "Case study"

  Scenario:
    When I visit "/log-in-file-self-assessment-tax-return/sign-in/prove-identity"
    Then I should see "Prove your identity to continue"
    And I should see a radio button for "use-government-gateway"
    And I should see a radio button for "use-gov-uk-verify"
    And I should see a radio button for "register-for-self-assessment"
    And I should see a continue button

  Scenario:
    When I visit "/log-in-file-self-assessment-tax-return/sign-in/prove-identity"
    When I choose "Use Government Gateway"
    Then I should be redirected to "https://www.tax.service.gov.uk/gg/sign-in?continue=/account"

  Scenario:
    When I visit "/log-in-file-self-assessment-tax-return/sign-in/prove-identity"
    When I choose "Use GOV.UK Verify"
    Then I should be redirected to "https://www.signin.service.gov.uk/start"

  Scenario:
    When I visit "/log-in-file-self-assessment-tax-return/sign-in/prove-identity"
    When I choose "Register for Self Assessment"
    Then I should be redirected to "/log-in-file-self-assessment-tax-return/sign-in/register-self-assessment"

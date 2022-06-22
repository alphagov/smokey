@replatforming @app-asset-manager
Feature: Assets
  @local-network
  Scenario: Check assets can be managed via the API
    Given I am testing "asset-manager" internally
    And I am an authenticated API client
    When I request "/assets/513a0efbed915d425e000002"
    And I should see "120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg"

  Scenario: Check an asset can be served
    Given I am testing "assets"
    When I request "/media/580768d940f0b64fbe000022/Target_incomes_calculator.xls"
    Then I should get a "Content-Type" header of "application/vnd.ms-excel"

  Scenario: Check a draft asset can be served
    Given I am testing "draft-assets"
    When I visit "/media/513a0efbed915d425e000002/120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg"
    Then I should be redirected to signon
    When I log in using valid credentials
    And I should see the draft image asset

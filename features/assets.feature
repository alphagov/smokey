@replatforming @app-asset-manager
Feature: Assets
  Tests for assets and asset-manager, including draft assets which are behind
  signon.

  @local-network
  Scenario: Check an asset can be loaded
    Given I am testing "asset-manager" internally
    And I am an authenticated API client
    When I request "/assets/513a0efbed915d425e000002"
    And I should see "120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg"

  # TODO: RENAME to clarify this is testing that an asset can be served.
  #
  Scenario: Check assets with an xls extension are served correctly
    Given I am testing "assets"
    When I request "/media/580768d940f0b64fbe000022/Target_incomes_calculator.xls"
    Then I should get a "Content-Type" header of "application/vnd.ms-excel"

  @app-authenticating-proxy
  Scenario: Check draft assets require authentication
    Given I am testing "draft-assets"
    When I visit "/media/123/filename.extension"
    Then I should be redirected to signon

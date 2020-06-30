Feature: Assets
  Tests for assets and asset-manager, including draft assets which are behind
  signon.

  Scenario: Check assets are being served
    Given I am testing "assets"
    When I request "/__canary__"
    Then JSON is returned

  @local-network
  Scenario: Check an asset can be loaded
    Given I am testing "asset-manager" internally
    And I am an authenticated API client
    When I request "/assets/513a0efbed915d425e000002"
    And I should see "120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg"

  Scenario: Check an asset can be served
    Given I am testing "assets"
    When I request "/media/513a0efbed915d425e000002/120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg"
    And I should get a content length of "212880"

  Scenario: Check assets with a docx extension are served correctly
    Given I am testing "assets"
    When I request "/media/59f70d5640f0b66bbc806ed3/questionnaire-for-accommodation-providers-online-hotel-booking.docx"
    Then I should get a "Content-Type" header of "application/vnd.openxmlformats-officedocument.wordprocessingml.document"

  Scenario: Check assets with an xls extension are served correctly
    Given I am testing "assets"
    When I request "/media/580768d940f0b64fbe000022/Target_incomes_calculator.xls"
    Then I should get a "Content-Type" header of "application/vnd.ms-excel"

  @draft-assets
  Scenario: Check draft assets require authentication
    When I visit "/media/123/filename.extension"
    Then I should be redirected to signon

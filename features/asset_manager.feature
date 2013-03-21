Feature: Asset Manager

  @local-network
  @normal
  Scenario: check an asset can be loaded
    Given the "asset-manager" application has booted
    When I visit "/assets/513a0efbed915d425e000002"
    Then I should get a 200 status code
    And I should see "120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg"

  @normal
  Scenario: check an asset can be served
    Given I am testing "static"
    When I visit "/media/513a0efbed915d425e000002/120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg"
    Then I should get a 200 status code
    And I should get a content length of "212880"

Feature: Assets

  @high
  Scenario: Assets are being served
    Given I am testing "assets"
    When I request "/__canary__"
    Then I should get a 200 status code

  @normal
  Scenario: Assets with an explicit Content-Type are served with the correct Content-Type
    Given I am testing "assets"
    When I request "/media/59f70d5640f0b66bbc806ed3/questionnaire-for-accommodation-providers-online-hotel-booking.docx"
    Then I should get a "Content-Type" header of "application/octet-stream"

  @normal
  Scenario: Assets without an explicit Content-Type are served with the correct Content-Type
    Given I am testing "assets"
    When I request "/media/580768d940f0b64fbe000022/Target_incomes_calculator.xls"
    Then I should get a "Content-Type" header of "application/octet-stream"

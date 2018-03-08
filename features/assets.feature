Feature: Assets

  @high
  Scenario: Assets are being served
    Given I am testing "assets-origin"
    When I request "/__canary__"
    Then I should get a 200 status code

  @normal
  Scenario: Assets with a docx extension
    Given I am testing "assets-origin"
    When I request "/media/59f70d5640f0b66bbc806ed3/questionnaire-for-accommodation-providers-online-hotel-booking.docx"
    Then I should get a "Content-Type" header of "application/vnd.openxmlformats-officedocument.wordprocessingml.document"

  @normal
  Scenario: Assets with a xls extension
    Given I am testing "assets-origin"
    When I request "/media/580768d940f0b64fbe000022/Target_incomes_calculator.xls"
    Then I should get a "Content-Type" header of "application/vnd.ms-excel"

  @normal @draft-assets
  Scenario: Draft assets
    When I visit "/media/123/filename.extension"
    Then I should be redirected to signon

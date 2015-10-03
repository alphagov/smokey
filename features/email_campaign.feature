Feature: Email campaign

  @high
  Scenario: viewing the press release and the campaign
    When I visit the email campaign press release page
    Then I should be asked to confirm my location
    #When I give my location as "United Kingdom" and return to the press release page
    When I give my location as "United Kingdom"
    Then I should see the press release
    When I follow the link to the campaign
    Then I should see the campaign page

  @high
  Scenario: viewing the campaign page directly
    When I visit the email campaign page
    Then I should be asked to confirm my location
    When I give my location as "United Kingdom"
    Then I should see the campaign page

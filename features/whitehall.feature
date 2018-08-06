Feature: Whitehall
  Tests for the whitehall application that powers some pages under
  www.gov.uk/government and www.gov.uk/world.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: Check the government publishing section on GOV.UK homepage
    Then I should see the departments and policies section on the homepage

  @normal @notintegration
  Scenario: There should be no authentication for Whitehall
    Then I should be able to view policies
    And I should be able to view announcements
    And I should be able to view publications
    Then I should be able to visit:
      | Path                      |
      | /government/topics        |
      | /government/consultations |
      | /government/ministers     |
      | /government/world         |

  @normal
  Scenario: Check searching for an existing consultation on whitehall
    When I do a whitehall search for "Assessing radioactive waste disposal sites"
    Then I should see "Assessing radioactive waste disposal sites"

  @normal
  Scenario: Check feeds are available for documents
    Then I should be able to visit:
      | Path                           |
      | /government/announcements.atom |
      | /government/publications.atom  |

  @normal
  Scenario: Check whitehall pages load
    Then I should be able to view policies
    And I should be able to view announcements
    And I should be able to view publications
    Then I should be able to visit:
      | Path                             |
      | /government/how-government-works |
      | /government/get-involved         |
      | /government/topics               |
      | /government/consultations        |
      | /government/ministers            |
      | /government/world                |

  @normal
  Scenario: Check whitehall assets are redirected to and served from the asset host
    When I request an attachment
    Then I should be redirected to the asset host
    And the attachment should be served successfully

  @normal
  Scenario Outline: Formats rendered by Whitehall respond OK
    When I request "<Path>"
    Then I should see "<Expected string>"

    Examples:
      | Path                             | Expected string         |
      | /government/how-government-works | How government works    |
      | /government/people/eric-pickles  | The Rt Hon Lord Pickles |

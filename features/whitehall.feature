@aws
Feature: Whitehall
  Tests for the whitehall application that powers some pages under
  www.gov.uk/government and www.gov.uk/world.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: Check the government publishing section on GOV.UK homepage
    Then I should see the departments and policies section on the homepage

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
  Scenario Outline: Check whitehall pages load
    Then I should be able to view announcements
    And I should be able to view publications
    When I request "<Path>"
    Then I should get a 200 status code

    Examples:
      | Path                             |
      | /government/how-government-works |
      | /government/get-involved         |
      | /government/consultations        |
      | /government/ministers            |
      | /government/people/eric-pickles  |
      | /world                           |

  @normal
  Scenario: Check whitehall assets are redirected to and served from the asset host
    When I request an attachment
    Then I should be redirected to the asset host
    And the attachment should be served successfully

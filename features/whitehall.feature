@aws
Feature: Whitehall
  Tests for the whitehall application that powers some pages under
  www.gov.uk/government and www.gov.uk/world.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  Scenario: Check the government publishing section on GOV.UK homepage
    Then I should see the departments and policies section on the homepage

  Scenario: Check feeds are available for documents
    Then I should be able to visit:
      | Path                           |
      | /government/announcements.atom |
      | /government/statistics.atom  |

  Scenario Outline: Check whitehall pages load
    When I request "<Path>"
    Then I should get a 200 status code

    Examples:
      | Path                             |
      | /government/how-government-works |
      | /government/get-involved         |
      | /government/ministers            |
      | /government/people/eric-pickles  |
      | /world                           |

  Scenario: Check whitehall assets are redirected to and served from the asset host
    When I request an attachment
    Then I should be redirected to the asset host
    And the attachment should be served successfully

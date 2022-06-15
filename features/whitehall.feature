@replatforming @app-whitehall
Feature: Whitehall
  Tests for the whitehall application that powers some pages under
  www.gov.uk/government and www.gov.uk/world.

  # TODO: RENAME to clarify this is testing data transfer with
  # Content Store (as the prime example for this app).
  #
  # This test is poor quality as content is not explicitly tested,
  # but there are no better tests to choose from.
  #
  Scenario Outline: Check whitehall pages load
    When I request "<Path>"
    Then I should get a 200 status code

    Examples:
      | Path                             |
      | /government/ministers            |

  Scenario: Check whitehall assets are redirected to and served from the asset host
    When I request an attachment
    Then I should be redirected to the asset host
    And the attachment should be served successfully

@replatforming @app-asset-manager
Feature: Assets
  Tests for assets and asset-manager, including draft assets which are behind
  signon.

  # TODO: REMOVE this test as it does not meet the elgibility
  # criteria in docs/writing-tests.md.
  #
  # - Covers site-wide config: N (already covered)
  # - Targets data transfer: N (not applicable)
  # - Second critical check: N (not applicable)
  #
  # This test checks the assets origin works [^1] and predates
  # the other tests here [^2] that cover the same in more depth
  # e.g. "Check assets with an xls extension are served correctly".
  #
  # [^1]: https://github.com/alphagov/govuk-puppet/blob/32c1bbbb10067078c1406170666a135b4a10aaea/modules/router/templates/assets_origin.conf.erb#L76
  # [^2]: https://github.com/alphagov/smokey/commit/91bb195fff35b3398a8f442ba489284964a9e0ea
  #
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

  # TODO: REMOVE as this test is a duplicate.
  #
  # Duplicate of "Check assets with an xls extension are served correctly".
  #
  Scenario: Check an asset can be served
    Given I am testing "assets"
    And I force a varnish cache miss
    When I request "/media/513a0efbed915d425e000002/120613_Albania_Travel_Advice_WEB_Ed2_jpeg.jpg"
    And I should get a content length of "212880"

  # TODO: REMOVE as this test is a duplicate.
  #
  # Duplicate of "Check assets with an xls extension are served correctly".
  #
  # Note: this was originally testing a bug [^1][^2] but no longer:
  # the object in S3 no longer has a content type set as described.
  #
  # Since this feature was at best an intermittent way of detecting
  # the bug and since it's been broken for an unknown period, I think
  # it's safe to remove it for now.
  #
  # [^1]: https://github.com/alphagov/smokey/commit/3725f865d22340698fad39ae7f3cca20d0d2ecfa
  # [^2]: https://github.com/alphagov/govuk-puppet/commit/79a0bfec37d193c55c40787375a721408db606ce
  #
  Scenario: Check assets with a docx extension are served correctly
    Given I am testing "assets"
    And I force a varnish cache miss
    When I request "/media/59f70d5640f0b66bbc806ed3/questionnaire-for-accommodation-providers-online-hotel-booking.docx"
    Then I should get a "Content-Type" header of "application/vnd.oasis.opendocument.text"

  # TODO: RENAME to clarify this is testing that an asset can be served.
  #
  Scenario: Check assets with an xls extension are served correctly
    Given I am testing "assets"
    And I force a varnish cache miss
    When I request "/media/580768d940f0b64fbe000022/Target_incomes_calculator.xls"
    Then I should get a "Content-Type" header of "application/vnd.ms-excel"

  @app-authenticating-proxy
  Scenario: Check draft assets require authentication
    Given I am testing "draft-assets"
    When I visit "/media/123/filename.extension"
    Then I should be redirected to signon

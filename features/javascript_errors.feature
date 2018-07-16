Feature: Smokey JavaScript error detection

  # This test checks that the @ignore_javascript_errors successfully ignores JavaScript errors. It is placed before
  # the JS error detection test to ensure that it is also correctly torn down
  @ignore_javascript_errors
  Scenario: Ignore JS errors with the correct tag
    When I inject a JavaScript error on the page, Smokey does not raise an exception

  @normal
  Scenario: Smokey detects JS errors
    When I inject a JavaScript error on the page, Smokey raises an exception

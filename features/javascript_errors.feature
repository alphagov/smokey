Feature: Smokey Javascript Error detection

  @normal
  Scenario: Smokey detects JS errors
    When I inject a JavaScript error on the page, Smokey raises an exception
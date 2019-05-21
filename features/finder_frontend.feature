Feature: Finder Frontend
  These are pages that let you search within a set of similar looking documents.

  Background:
    Given I am testing through the full stack
    And I force a varnish cache miss

  @normal
  Scenario: Check people page loads correctly
    When I visit "/government/people"
    Then I should see "All ministers and senior officials on GOV.UK"
    And I should see an input field to search

  @normal
  Scenario: Check world organisations loads correctly
    When I visit "/world/organisations"
    Then I should see "Worldwide organisations"
    And I should see an input field to search

  @normal
  Scenario: Check groups loads correctly
    When I visit "/government/groups"
    Then I should see "Groups"
    And I should see an input field to search

  @normal
  Scenario: Check case studies loads correctly
    When I visit "/government/case-studies"
    Then I should see "Case studies: Real-life examples of government activity"
    And I should see an input field to search

  @normal
  Scenario: Check contacts finder loads correctly
    When I visit "/government/organisations/hm-revenue-customs/contact"
    Then I should see "Contact HM Revenue &amp; Customs"
    And I should see an input field to search

  @normal
  Scenario: Check statistical data sets loads correctly
    When I visit "/government/statistical-data-sets"
    Then I should see "Statistical data sets"
    And I should see an input field to search

  @normal
  Scenario: Check specialist documents are searchable
    When I visit "/cma-cases?keywords=merger"
    Then I should see filtered documents
    And I should see an open facet titled "Case type" with non-blank values

  @normal
  Scenario: Check advanced search returns results
    When I visit "/search/advanced?topic=/education&group=news_and_communications"
    Then I should see filtered documents

  @high
  Scenario Outline: Check malicious code does not execute
    When I visit the "<finder>" finder with keywords <keyword>
    Then There should be no alert
    When I visit the "<finder>" finder without keywords
    And I fill in the keyword field with <keyword>
    Then There should be no alert
    And I should see the string <keyword>

  Examples: news-and-communications finder
    | keyword                                              |  finder                      |
    |<script>alert(123)</script>                           | news-and-communications      |
    |&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;    | news-and-communications      |
    |<img src=x onerror=alert(123) />                      | news-and-communications      |
    |<svg><script>123<1>alert(123)</script>                | news-and-communications      |
    |\"><script>alert(123)</script>                        | news-and-communications      |
    |'><script>alert(123)</script>                         | news-and-communications      |
    |><script>alert(123)</script>                          | news-and-communications      |
    |</script><script>alert(123)</script>                  | news-and-communications      |
    |< / script >< script >alert(123)< / script >          | news-and-communications      |
    | onfocus=JaVaSCript:alert(123) autofocus              | news-and-communications      |
    |\" onfocus=JaVaSCript:alert(123) autofocus            | news-and-communications      |
    |' onfocus=JaVaSCript:alert(123) autofocus             | news-and-communications      |
    |＜script＞alert(123)＜/script＞                        | news-and-communications      |
    |<sc<script>ript>alert(123)</sc</script>ript>          | news-and-communications      |
    |--><script>alert(123)</script>                        | news-and-communications      |
    |\";alert(123);t=\"                                    | news-and-communications      |
    |';alert(123);t='                                      | news-and-communications      |
    |JavaSCript:alert(123)                                 | news-and-communications      |
    |;alert(123);                                          | news-and-communications      |
    |\"><script>alert(123);</script x=\"                   | news-and-communications      |
    |'><script>alert(123);</script x='                     | news-and-communications      |
    |><script>alert(123);</script x=                       | news-and-communications      |
  Examples: all finder
    | keyword                                              |  finder                      |
    |<script>alert(123)</script>                           | all                          |
    |&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;    | all                          |
    |<img src=x onerror=alert(123) />                      | all                          |
    |<svg><script>123<1>alert(123)</script>                | all                          |
    |\"><script>alert(123)</script>                        | all                          |
    |'><script>alert(123)</script>                         | all                          |
    |><script>alert(123)</script>                          | all                          |
    |</script><script>alert(123)</script>                  | all                          |
    |< / script >< script >alert(123)< / script >          | all                          |
    | onfocus=JaVaSCript:alert(123) autofocus              | all                          |
    |\" onfocus=JaVaSCript:alert(123) autofocus            | all                          |
    |' onfocus=JaVaSCript:alert(123) autofocus             | all                          |
    |＜script＞alert(123)＜/script＞                        | all                          |
    |<sc<script>ript>alert(123)</sc</script>ript>          | all                          |
    |--><script>alert(123)</script>                        | all                          |
    |\";alert(123);t=\"                                    | all                          |
    |';alert(123);t='                                      | all                          |
    |JavaSCript:alert(123)                                 | all                          |
    |;alert(123);                                          | all                          |
    |\"><script>alert(123);</script x=\"                   | all                          |
    |'><script>alert(123);</script x='                     | all                          |
    |><script>alert(123);</script x=                       | all                          |

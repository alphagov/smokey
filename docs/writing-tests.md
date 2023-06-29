# Writing tests

## What belongs here

This repo contains tests that check critical areas of GOV.UK are working as expected. Any new test should meet one or more of the following criteria:

- **Covers vital site-wide configuration**. The test checks that the foundations of GOV.UK exist, with some indication they work as expected:

  - [Good example](https://github.com/alphagov/smokey/blob/aaa0522/features/mirror.feature#L11) - covers fallback mirrors exist
  - [Good example](https://github.com/alphagov/smokey/blob/aaa0522/features/gov_uk_redirect.feature#L13) - covers Fastly CDN configuration
  - [Bad example](https://github.com/alphagov/smokey/blob/aaa0522/features/gov_uk.feature#L9) - covers an edge case of limited value
  - [Bad example](https://github.com/alphagov/smokey/blob/aaa0522/features/gov_uk.feature#L27) - covers a negative or "unhappy" outcome

- **Targets app-to-app data transfer**. The test checks that data can flow between multiple apps to provide an end-to-end feature of GOV.UK:

  - [Good example](https://github.com/alphagov/smokey/blob/aaa0522/features/service_manual.feature#L7) - basic test that an app is accessible via Router
    - Implicitly checks the app can talk to the Content Store
    - Each app can have one (and only one) of these tests
  - [Good example](https://github.com/alphagov/smokey/blob/aaa0522/features/collections.feature#L53) - covers data transfer with Email Alert API
  - [Bad example](https://github.com/alphagov/smokey/blob/aaa0522/features/router.feature#L8) - doesn’t check content data was transferred
  - [Bad example](https://github.com/alphagov/smokey/blob/0d7134e/features/benchmarking.feature#L7) - performance testing is out-of-scope

- **Second critical functional check**. A very similar test exists at a lower level but the functionality is so absolutely critical we test it again:

  - [Good example](https://github.com/alphagov/smokey/blob/aaa0522/features/frontend.feature#L18) - undeniably a critical page for GOV.UK ([lower level test exists](https://github.com/alphagov/frontend/blob/a40ba98/test/integration/help_test.rb#L18))
  - [Good example](https://github.com/alphagov/smokey/blob/aaa0522/features/frontend.feature#L59) - one of the most critical features of GOV.UK ([lower level test exists](https://github.com/alphagov/router/blob/96d5912/integration_tests/redirect_test.go?L23#L12))
  - [Bad example](https://github.com/alphagov/smokey/blob/aaa0522/features/collections.feature#L29) - checks an arbitrary, non-critical page ([lower level test exists](https://github.com/alphagov/collections/blob/cc94525/features/viewing_browse.feature))
  - [Bad example](https://github.com/alphagov/smokey/blob/aaa0522/features/finder_frontend.feature#L45) - missing a lower level test in the app itself ([example test to copy](https://github.com/alphagov/finder-frontend/blob/d70a019/spec/controllers/email_alert_subscriptions_controller_spec.rb#L363))

Do not duplicate tests. For example, ["Email signup from an organisation home page"](https://github.com/alphagov/smokey/blob/aaa0522/features/collections.feature#L47) duplicates ["Email signup from a taxon page"](https://github.com/alphagov/smokey/blob/aaa0522/features/collections.feature#L53): both cover data transfer with Email Alert API.

Do not add tests that can be implemented in other ways. We want this to be the tip of the [testing pyramid](https://martinfowler.com/bliki/TestPyramid.html), not a [testing ice cream cone](http://saeedgatson.com/the-software-testing-ice-cream-cone/). Instead of adding a test here, you can:

- Add or extend [health checks for application infrastructure](https://github.com/alphagov/govuk_app_config/blob/main/docs/healthchecks.md). For example, drafting a document in a publishing app involves connecting to infrastructure like a database or AWS S3.

- Add [contract tests](https://docs.publishing.service.gov.uk/manual/pact-broker.html) to cover a chain of APIs. For example, subscribing to an email involves communication with Email Alert API and Content Store, which can be tested via GDS API Adapters.

- Add unit or integration tests to cover in-app behaviour. For example, the way each document format is rendered can be tested in the frontend app that does the rendering.

In contrast, the tests in this repo provide coverage at a higher level. We should be willing to page someone when tests are failing, once they are reliable enough.

## Adding new tests

Scenarios should be organised by the "component" they are testing:

- **`apps/<app>.feature`** should contain tests that target a feature of \<app\> e.g.

  - "[Email signup from foreign travel advice](https://github.com/alphagov/smokey/blob/a529bae/features/foreign_travel_advice.feature#L15)" is targeting Government Frontend, so should be in `apps/government_frontend.feature`.

  - "[Can log in to collections-publisher](https://github.com/alphagov/smokey/blob/a529bae/features/publishing_tools.feature#L4)" is targeting Collections Publisher, so should be in `apps/collections_publisher.feature`.

- **`<layer>.feature`** should contain tests that target an infrastructure layer e.g.

  - "[Check redirect from bare domain to www.gov.uk is working for HTTP](https://github.com/alphagov/smokey/blob/a529bae/features/gov_uk_redirect.feature#L3)" is [targeting site-wide behaviour of our CDN](https://github.com/alphagov/govuk-cdn-config/blob/8ca5780/vcl_templates/tldredirect.vcl.erb#L46), so should be in `cdn.feature`.

  - "[Check visiting a draft page requires a signon session](https://github.com/alphagov/smokey/blob/a529bae/features/draft_environment.feature#L11)" is targeting site-wide behaviour of our (draft) origin, so should be in `origin.feature`.

Try to use existing step definitions e.g. [`When I visit "/some/path"`](https://github.com/alphagov/smokey/blob/b656e65/features/step_definitions/smokey_steps.rb#L70-L72). If a more specific step is required, name the `_steps.rb` file after the feature file i.e. `myfeature_steps.rb`.

### Tests that makes changes to GOV.UK

Any test that changes GOV.UK must be discreet:

1. Any page that is published must not be visible to search engines or linked to from elsewhere on GOV.UK. Ideally it should only be visible internally.

2. Any trace of the change should be hidden from departmental users. For example, a document could be published in a dedicated "test" organisation.

3. Data must not accumulate over time - tests run many times a day. Running the test multiple times should have no impact on databases or other storage.

If criteria (1) or (3) can’t be met in Production, then it’s acceptable to only run the test in Integration or Staging, where [the data is wiped daily](https://docs.publishing.service.gov.uk/manual/govuk-env-sync.html).

Tests that change state are particularly vulnerable to flakiness. You must ensure any new tests are highly reliable after they are added ([bad example](https://github.com/alphagov/smokey/pull/916)).

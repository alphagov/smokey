# GOV.UK Smoke Tests

Automated tests that describe high level user journeys which touch multiple
applications within the GOV.UK stack.

These are used to verify releases and also to provide Nagios alerts for major
features.

## Technical documentation

The smoke tests are based on [Cucumber](http://cukes.info/). We use feature
files to describe single applications (eg
[`whitehall`](https://github.com/alphagov/whitehall),
[`frontend`](https://github.com/alphagov/frontend)).

### Running the tests

Run the suite with:

```
bundle exec rake
```

or against a single `feature`:

```
bundle exec cucumber features/frontend.feature
```

The tests run in/against the integration environment by default but require additional configuration to run successfully. This set of options should allow you to run the tests successfully from your development machine:

```
GOVUK_DRAFT_WEBSITE_ROOT=https://draft-origin.integration.publishing.service.gov.uk \
SIGNON_EMAIL="<email-address>" \
SIGNON_PASSWORD="<password>" \
AUTH_USERNAME="<username>" \
AUTH_PASSWORD="<password>" \
bundle exec cucumber \
--format pretty \
--tags ~@pending \
--tags ~@local-network \
--tags ~@notintegration
```

### Test configuration

You can use the following environment variables to configure the tests:

* `GOVUK_WEBSITE_ROOT`
  * Default: https://www-origin.integration.publishing.service.gov.uk
  * The environment to run the Smoke tests in.
* `GOVUK_DRAFT_WEBSITE_ROOT`
  * Default: The value returned by [`plek`](http://github.com/alphagov/plek) for `draft-origin`.
  * Required by tests tagged with `@draft`.
* `GOVUK_APP_DOMAIN`
  * Default: Blank
  * Used to construct URLs in the `#application_base_url` method.
* `AUTH_USERNAME`
  * Default: Blank
  * Set the HTTP Basic username required to access `GOVUK_WEBSITE_ROOT`.
* `AUTH_PASSWORD`
  * Default: Blank
  * Set the HTTP Basic password required to access `GOVUK_WEBSITE_ROOT`.
* `SIGNON_EMAIL`
  * Default: Blank
  * Email address of a user with a Signon account in the environment the tests are being run in.
* `SIGNON_PASSWORD`
  * Default: Blank
  * Password of a user with a Signon account in the environment the tests are being run in.

### Debugging the tests

Set the `POLTERGEIST_DEBUG` environment variable to see Poltergeist debug output when running the tests:

```
$ POLTERGEIST_DEBUG=true bundle exec rake
```

### Adding new tests

Tests that are supposed to be run by icinga also have to be added to the file
`modules/monitoring/manifests/checks/smokey.pp` in our Puppet repository. For
example, the test [frontend.feature](/features/frontend.feature)
is added to icinga like this:

```puppet
icinga::check_feature {
  'check_frontend':          feature => 'frontend';
  #other feature tests
}
```

### Prioritising scenarios

Because we integrate Nagios with the output from these tests, we provide a set
of tags which match with how important we consider a scenario to be. `@high` and
above will trigger pager alerts.

Each scenario can and should be prioritised by using the `@urgent`, `@high`,
`@normal` or `@low` cucumber tags. For example, the frontend scenario "check
guides load" can be prioritised like this:

```cucumber
@low
Scenario: check guides load
  When I visit "/getting-an-mot/overview"
  Then I should see "Getting an MOT"
```

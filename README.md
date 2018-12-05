# GOV.UK Smoke Tests

Automated tests that describe high level user journeys which touch multiple
applications within the GOV.UK stack.

These are used to verify releases and also to provide Icinga alerts for major
features.

## Technical documentation

The smoke tests are based on [Cucumber](https://cucumber.io/). We use feature
files to describe single applications (eg
[`whitehall`](https://github.com/alphagov/whitehall),
[`frontend`](https://github.com/alphagov/frontend)) or [cross-application behaviour](features/gov_uk.feature).

### Running the tests

Run the suite with:

```
bundle exec rake
```

or against a single `feature`:

```
bundle exec cucumber features/frontend.feature
```

The tests require additional configuration to run successfully. This set of options should allow you to run the tests successfully from your development machine:

```
ENVIRONMENT=integration \
SIGNON_EMAIL="<email-address>" \
SIGNON_PASSWORD="<password>" \
bundle exec cucumber \
--format pretty \
--tags "not @pending" \
--tags "not @local-network" \
--tags "not @notintegration"
```

### Test configuration

You can use the following environment variables to configure the tests:

* `ENVIRONMENT`
  * Default: Blank
  * The environment to run the smoke tests in.
* `GOVUK_WEBSITE_ROOT`
  * Default: The website root corresponding to the chosen environment.
  * Used when checking for the correct URLs in tests.
* `GOVUK_DRAFT_WEBSITE_ROOT`
  * Default: The value returned by [`plek`](http://github.com/alphagov/plek) for `draft-origin`.
  * Required by tests tagged with `@draft`.
* `GOVUK_APP_DOMAIN`
  * Default: The app domain corresponding to the chosen environment.
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
* `RATE_LIMIT_TOKEN`
  * Default: Blank
  * A token used to bypass the default rate limiting.

### Spoofing the target domain

Set the `SPOOF_TARGET_DOMAIN` environment variable to run tests against a alternative URL, while maintaining the `Host` header as set by the `GOVUK_WEBSITE_ROOT` environment variable.

This may be useful when you wish to test against the FQDN of a site where the DNS does not yet resolve to the correct IP.

An alternative method would be to update `/etc/hosts` on the client running the tests.

### Adding new tests

Tests that are supposed to be run by Icinga also have to be added to the file
`modules/monitoring/manifests/checks/smokey.pp` in the [govuk-puppet](https://github.com/alphagov/govuk-puppet) repository. For
example, the test [frontend.feature](/features/frontend.feature)
is added to Icinga like this:

```puppet
icinga::check_feature {
  'check_frontend':          feature => 'frontend';
  #other feature tests
}
```

### Prioritising scenarios

Because we integrate Icinga with the output from these tests, we provide a set
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

### Deploying

The master branch of this Smokey project is automatically [deployed by Jenkins at about 9am each day](https://github.com/alphagov/govuk-puppet/blob/master/modules/govuk_jenkins/templates/jobs/smokey_deploy.yaml.erb#L33) to the monitoring machines to run the Smokey loop. The Smokey that runs after deployments is always the latest version from the master branch and does not need deployment.

### Use of BrowserMob Proxy

Smokey uses BrowserMob Proxy as a proxy between the feature tests and Selenium. The proxy allows manipulation of HTTP request headers, which is not supported by Selenium. The proxy consists of a runner in `bin` and a JAR containing the application in `lib`.

### Use of scripts

* `tests_json_output.sh`: Used to run the Smokey loop on the monitoring machines and output JSON to a temporary file.
* `nagios_check_cache.py`: Used by Icinga to check the JSON in the temporary file created by the Smokey loop and determine the current status (pass/fail).
* `deploy.sh`: Used by Jenkins when running the `Smokey_Deploy` job to deploy Smokey to the monitoring machines.
* `jenkins.sh`: Used by Jenkins to run a one-off Smokey after a deployment.

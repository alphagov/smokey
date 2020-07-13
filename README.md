# GOV.UK Smoke Tests

Automated tests that describe high level user journeys which touch multiple
applications within the GOV.UK stack.

The master branch of the tests is frequently run in all environments, triggered by deployments of most GOV.UK applications, CDNs and associated dependencies ([check here](https://github.com/alphagov/govuk-puppet/search?l=HTML%2BERB&q=smokey)).

The tests also run in [a continuous Smokey loop](https://github.com/alphagov/govuk-puppet/blob/master/modules/monitoring/templates/smokey-loop.conf), using a version of the master branch [deployed by Jenkins each day](https://github.com/alphagov/govuk-puppet/blob/master/modules/govuk_jenkins/templates/jobs/smokey_deploy.yaml.erb). We use the Smokey loop to provide Icinga alerts for major features.

## Installation

Smokey requires Java to be installed, because of its use of the BrowserUp Proxy.

- On your host Mac, run `brew cask install adoptopenjdk`.

- If you don't have Homebrew installed, [download the Java JDK from the AdpotOpenJDK website](https://adoptopenjdk.net/).

After that, it's a standard Ruby setup: `bundle install`.

## Running the tests

The tests require additional configuration to run successfully on a local machine.

```
ENVIRONMENT=integration \
SIGNON_EMAIL="<email-address>" \
SIGNON_PASSWORD="<password>" \
AUTH_USERNAME="<username>" \
AUTH_PASSWORD="<password>" \
bundle exec cucumber
```

You can use the following environment variables to configure the tests:

* `ENVIRONMENT`: used to set environment variables for [Plek](https://github.com/alphagov/plek)
* `AUTH_USERNAME`: the HTTP Basic auth username (required for Integration)
* `AUTH_PASSWORD`: the HTTP Basic auth password (required for Integration)
* `SIGNON_EMAIL`: email address of a user with a Signon account in the environment the tests are being run in
* `SIGNON_PASSWORD`: password of a user with a Signon account in the environment the tests are being run in
* `RATE_LIMIT_TOKEN`: a token used to bypass the default rate limiting

## Layout

The smoke tests are based on [Cucumber](https://cucumber.io/) and [use Selenium to manipulate a headless Chrome browser](features/support/env.rb). We use feature
files to describe single applications (eg
[`whitehall`](https://github.com/alphagov/whitehall),
[`frontend`](https://github.com/alphagov/frontend)) or [cross-application behaviour](features/gov_uk.feature).

We configure Selenium with a BrowserUp Proxy. The proxy allows us to capture and check for asynchronous requests made by JavaScript in our app e.g. for analytics. It relates to the following files:

* `bin/browserup-proxy`: a runner script
* `lib/*`: JARs for BrowserUp Proxy and its dependencies

This repo also contains several scripts to support external systems running the tests and checking their output.

* `tests_json_output.sh`: used to run the Smokey loop and output JSON to a temporary file
* `nagios_check_cache.py`: used by Icinga to check for pass/fail statuses in the JSON in the temporary file
* `deploy.sh`: used by Jenkins to deploy Smokey in order to run the Smokey loop
* `jenkins.sh`: used by Jenkins to run a one-off Smokey e.g. after a deployment

## Further documentation

- [troubleshooting](docs/troubleshooting.md)
- [writing-tests](docs/writing-tests.md)
- [pr-template](.github/pull_request_template.md)

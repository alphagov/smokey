# GOV.UK Smoke Tests

Automated tests that describe high level user journeys which touch multiple
applications within the GOV.UK stack.

These are used to verify releases and also to provide Icinga alerts for major
features.

The tests are run against training, integration, staging and production environments, and are triggered by deployments of most GOV.UK applications, CDNs and associated dependencies (`grep -i "smokey" modules/govuk_jenkins/templates/jobs/*` in the [govuk-puppet repository](https://github.com/alphagov/govuk-puppet) for a full list).

## Technical documentation

The smoke tests are based on [Cucumber](https://cucumber.io/). We use feature
files to describe single applications (eg
[`whitehall`](https://github.com/alphagov/whitehall),
[`frontend`](https://github.com/alphagov/frontend)) or [cross-application behaviour](features/gov_uk.feature).

### Installation

Smokey requires Java to be installed, because of its [use of the BrowserUp Proxy](#use-of-browserup-proxy). Note that if you're using the Development VM then Java is already installed.

If you're not using the VM, or want to run Smokey on your host Mac, run `brew cask install adoptopenjdk`.

If you don't have Homebrew installed, or are not using a Mac, you can [download the Java JDK from the AdpotOpenJDK website](https://adoptopenjdk.net/).

After that, it's a standard Ruby setup:

```
bundle install
```

## Running the tests

You must be disconnected from the VPN before attempting to run the tests locally.

The tests require additional configuration to run successfully on a local machine.

```
ENVIRONMENT=integration \
SIGNON_EMAIL="<email-address>" \
SIGNON_PASSWORD="<password>" \
AUTH_USERNAME="<username>" \
AUTH_PASSWORD="<password>" \
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

### HTTP status code failure

A common test failure is `HTTP status code 550 (RestClient::RequestFailed)`. This is a result of the BrowserUp Proxy java process running as part of a previously aborted smokey-loop and the new smoke tests cannot start a new proxy.

It's necessary to kill the existing java process (replace process numbers as appropriate).

```sh
$ ps -ef | grep java
> smokey    6385  6380 26 14:58 ?        00:00:54 java -Dapp.name=browserup-proxy -Dbasedir=/opt/smokey -jar /opt/smokey/lib/browserup-dist-2.0.1.jar --port 3222
$ sudo kill -9 6385
```

You can even set up an alias in your `~/.bash_profile`:

```sh
alias killbrowserup="ps xu | grep [b]rowserup-proxy | grep -v grep | awk '{ print \$2 }' | xargs kill -9"
```

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

### Use of BrowserUp Proxy

Smokey uses BrowserUp Proxy as a proxy between the feature tests and Selenium. The proxy allows manipulation of HTTP request headers, which is not supported by Selenium. The proxy consists of a runner in `bin` and a JAR containing the application in `lib`.

### Use of scripts

* `tests_json_output.sh`: Used to run the Smokey loop on the monitoring machines and output JSON to a temporary file.
* `nagios_check_cache.py`: Used by Icinga to check the JSON in the temporary file created by the Smokey loop and determine the current status (pass/fail).
* `deploy.sh`: Used by Jenkins when running the `Smokey_Deploy` job to deploy Smokey to the monitoring machines.
* `jenkins.sh`: Used by Jenkins to run a one-off Smokey after a deployment.

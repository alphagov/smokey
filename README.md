# GOV.UK Smoke Tests

Smokey is a suite of [Cucumber](https://cucumber.io/) tests that probe GOV.UK
frontend and backend publishing functionality. The tests [use Selenium to
automate a headless Chrome browser](features/support/env.rb).

Smokey is run automatically:

- every few minutes via a [cronjob][smokey-argo]
- by the [deployment
  automation](https://argo-workflows.eks.integration.govuk.digital/workflows?limit=100)
  to determine whether to promote a release to the next environment (staging,
  production)

You can also start a Smokey run [from Argo CD][smokey-argo]. Click the three
dots in the 'smokey' cronjob and choose 'Create Job'. It can take a few seconds
for the job to appear.

Each test should check that a critical area of GOV.UK is working as expected.
See the [guidance on what tests belong here and how to write new
ones](docs/writing-tests.md).

[smokey-argo]: https://argo.eks.integration.govuk.digital/applications/cluster-services/smokey

## Technical documentation

You can use the [GOV.UK Docker
environment](https://github.com/alphagov/govuk-docker) to run the application
and its tests with all the necessary dependencies. Follow [the usage
instructions](https://github.com/alphagov/govuk-docker#usage) to get started.

**Use GOV.UK Docker to run any commands that follow.**

### Run the test suite from your machine

> **You will need to be connected to the VPN to test against Integration or
> Staging.**

The tests require additional configuration to run successfully on a local
machine.

```
env \
ENVIRONMENT=integration \
SIGNON_EMAIL="<email-address>" \
SIGNON_PASSWORD="<password>" \
bundle exec cucumber
```

You can use the following environment variables to configure the tests:

* `ENVIRONMENT`: controls domains returned by
  [Plek](https://github.com/alphagov/plek) (see
  [env.rb](https://github.com/alphagov/smokey/blob/19c21ac/features/support/env.rb#L9-L21))
* `SIGNON_EMAIL`: email of a Signon user in $ENVIRONMENT
* `SIGNON_PASSWORD`: password of a Signon user in $ENVIRONMENT
* `RATE_LIMIT_TOKEN`: (optional) a token used to bypass rate limiting if present on apps.
* `GOVUK_PROXY_PROFILE` (optional) name of profile to use in govuk_proxy.rb. See [proxy tests](#proxy)

Smokey cannot use a Signon account which has multi-factor authentication
enabled.

To test against integration/staging from your machine, you can fetch
the Signon credentials for the Smokey test user:

```sh
k get secret smokey-signon-account -oyaml | yq .data.password | base64 -d
k get secret smokey-signon-account -oyaml | yq .data.email | base64 -d
```

### Proxy tests

The Smokey test suite can be told to run against our primary CDN (Fastly), our failover CDN (Cloudfront), or any one of the GOV.UK mirrors. To do so, you'll need to run the proxy in a separate process, and ensure you specify the `GOVUK_PROXY_PROFILE` environment variable.

Example of running Smokey tests against the main GOV.UK mirror:

```shell
shell1$ env GOVUK_PROXY_PROFILE=mirrorS3 ruby govuk_proxy_runner.rb

shell2$ env GOVUK_PROXY_PROFILE=mirrorS3 ENVIRONMENT=production bundle exec cucumber --tags="@worksonmirror"
```

Example of running Smokey tests against the failover CDN (NB: the 'secret' Cloudfront value can be [found in govuk-dns-tf](https://github.com/alphagov/govuk-dns-tf/pull/69)):

```shell
shell1$ env GOVUK_PROXY_PROFILE=failoverCDN FAILOVER_CDN_HOST="secret.cloudfront.net" ruby govuk_proxy_runner.rb

shell2$ env GOVUK_PROXY_PROFILE=failoverCDN ENVIRONMENT=production bundle exec cucumber --tags="not @notreplatforming and not @notcloudfront"
```

Debug mode for checking you're setting headers correctly:

```shell
env GOVUK_PROXY_PROFILE=debug ruby govuk_proxy_runner.rb
# Visit http://127.0.0.1:8080/ to see your request headers
```

## Further documentation

- [deployment](docs/deployment.md)
- [tagging](docs/tagging.md)
- [writing tests](docs/writing-tests.md)
- [pr-template](.github/pull_request_template.md)

## Licence

[MIT License](LICENCE)

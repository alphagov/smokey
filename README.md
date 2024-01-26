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

Read "[Environment variables](#environment-variables)" for an explanation of the environment variables used in the examples below.

*Run Smokey against Production*:

```sh
ENVIRONMENT=production \
SIGNON_EMAIL="<email-address>" \
SIGNON_PASSWORD="<password>" \
bundle exec cucumber --profile=production
```

You can test integration or staging by changing the value of the `ENVIRONMENT` variable and `profile` argument (see profiles in [`config/cucumber.yml`](./config/cucumber.yml)), but you need to be connected to the VPN.

You can run Smokey against the GOV.UK mirrors. The mirror tests are tagged `@worksonmirror`.

*Run Smokey against the primary mirror*:

```sh
ENVIRONMENT=production \
GOVUK_PROXY_PROFILE=mirrorS3 \
bundle exec cucumber --tags="@worksonmirror"
```

*Run Smokey against the failover CDN*:

```sh
ENVIRONMENT=production \
FAILOVER_CDN_HOST="<distribution>.cloudfront.net" \
GOVUK_PROXY_PROFILE=failoverCDN \
SIGNON_EMAIL="<email-address>" \
SIGNON_PASSWORD="<password>" \
bundle exec cucumber --tags="not @notproduction and not @notcloudfront"
```

### Run the proxy in isolation

When running Smokey against the failover CDN or mirrors, Smokey automatically proxies all requests through `GovukProxy`.
To help debug test failures, you can view pages through the proxy in your web browser.
In each example below, visit <http://127.0.0.1:8080> to see what the proxy is doing.

Proxy to the mirror:

```sh
GOVUK_PROXY_PROFILE=mirrorS3Replica ruby govuk_proxy_runner.rb
```

Proxy to the failover CDN:

```sh
FAILOVER_CDN_HOST="<distribution>.cloudfront.net" GOVUK_PROXY_PROFILE=failoverCDN ruby govuk_proxy_runner.rb
```

Debug mode (useful for confirming the host and headers you've set in `govuk_proxy_profiles.rb` are being applied):

```sh
GOVUK_PROXY_PROFILE=debug ruby govuk_proxy_runner.rb
```

### Environment variables

You can use the following environment variables to configure the tests:

* `ENVIRONMENT`: controls domains returned by
  [Plek](https://github.com/alphagov/plek) (see
  [env.rb](https://github.com/alphagov/smokey/blob/19c21ac/features/support/env.rb#L9-L21)).

* `SIGNON_EMAIL` and `SIGNON_PASSWORD`: credentials for a Signon user in $ENVIRONMENT.
  Smokey cannot use a Signon account which has multi-factor authentication enabled.
  To test against integration/staging from your machine, you can fetch the Signon credentials
  for the Smokey test user:

  ```sh
  k get secret smokey-signon-account -oyaml | yq .data.email | base64 -d
  k get secret smokey-signon-account -oyaml | yq .data.password | base64 -d
  ```

* `RATE_LIMIT_TOKEN`: (optional) a token used to bypass rate limiting if present on apps.

* `GOVUK_PROXY_PROFILE` (optional) name of profile to use in govuk_proxy.rb. Must be one of `failoverCDN`, `mirrorS3`, `mirrorS3Replica` or `mirrorGCS`

* `FAILOVER_CDN_HOST` (optional) required if `GOVUK_PROXY_PROFILE=failoverCDN`. Should be of the form `<distribution>.cloudfront.net`. Replace `<distribution>` with the CloudFront hostname in [govuk-dns-tf](https://github.com/alphagov/govuk-dns-tf/pull/69).

## Further documentation

- [deployment](docs/deployment.md)
- [tagging](docs/tagging.md)
- [writing tests](docs/writing-tests.md)
- [pr-template](.github/pull_request_template.md)

## Licence

[MIT License](LICENCE)

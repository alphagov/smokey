## Testing

**You should manually test your PR before merging.**

This app doesn't have CI setup, and it would be misleading to do so:
the behaviour of the tests changes depending on the environment they
are run in. You should manually test in applicable environments,
until you are confident your change is not a breaking one.

Example steps to test in Integration:

- Click "Configure" for the [Smokey job][]
- Change the "Branch specifier" to the name of your branch
- Run a new build of the Smokey project and check the results

## Deployment

**You need to manually deploy your PR after merging.**

Steps to deploy a change:

- Run the [Smokey deploy job][] to deploy the [continuous Smokey loop][]
- Repeat this in Staging and Production

> The manual [Smokey job][] will pick up changes on `master` automatically. You only need to do a manual deployment for the [continuous Smokey loop][].

[Smokey job]: https://deploy.integration.publishing.service.gov.uk/job/Smokey/
[continuous Smokey loop]: https://github.com/alphagov/govuk-puppet/blob/master/modules/monitoring/templates/smokey-loop.conf
[Smokey deploy job]: https://deploy.integration.publishing.service.gov.uk/job/Smokey_Deploy/

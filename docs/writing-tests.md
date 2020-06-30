# Writing tests

## Alerting in Icinga

In order to alert on a failing scenario in Icinga, you need to ensure the feature is [listed in the Puppet config](https://github.com/alphagov/govuk-puppet/blob/d7af16e96aed682facb5cf5bc3e3972510c64ca2/hieradata_aws/integration.yaml#L378).

## Filtering by app

The manual Smokey job also [has an option to filter by application](https://github.com/alphagov/govuk-puppet/blob/7f4b1684471daf09cff72c1372db88b1ed3fd1dc/modules/govuk_jenkins/templates/jobs/smokey.yaml.erb#L34), so that we can avoid running the entire tests suite. To make use of this filtering, you need to tag the relevant scenarios (or entire feature) with `@app-<app_name>`.

> `<app_name>` should match the list for the Deploy_App job (see [here](https://github.com/alphagov/govuk-puppet/blob/7f4b1684471daf09cff72c1372db88b1ed3fd1dc/hieradata_aws/common.yaml#L145)), [to support Continuous Deployment](https://github.com/alphagov/smokey/pull/675).

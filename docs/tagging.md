# Tagging

`@...` tags should _only_ be used for filtering ([not functionality hooks](https://github.com/alphagov/smokey/pull/903)).

## `@app-<app_name>`

The Smokey job in Jenkins [has an option to filter scenarios by application](https://github.com/alphagov/govuk-puppet/blob/7f4b168/modules/govuk_jenkins/templates/jobs/smokey.yaml.erb#L34), so that we can avoid running the entire test suite when only some scenarios are relevant to a change. To associate tests with an app, you need to tag the relevant scenarios (or entire feature) with `@app-<app_name>`.

> **Ensure `<app_name>` matches the name of the app's Argo CD application
> resource under `govukApplications` in
> [`values-<environment>.yaml`](https://github.com/alphagov/govuk-helm-charts/blob/cda3239/charts/app-config/values-integration.yaml#L45).**
> If these don't match then the scenario will not block promotion of a release
> of that app to staging/production.

## `@not<environment>`

All features should run in **all** environments. Sometimes this isn't possible, for example where:

- [The actual functionality only exists in
  Production](https://github.com/alphagov/smokey/blob/83fa09a/features/mirror.feature).
  Tag the feature or scenario with `@notintegration` and `@notstaging` so it
  doesn't run in these environments i.e. its only runs in Production.
- The test creates or modifies content which can't yet be done in production.

## `@pending`

This will stop a feature or scenario from running in all environments.

**Only use this tag if you know you will re-enable it soon**. Otherwise, it's clearer to just remove it - either way you will need to make a PR to restore it, so the amount of work is similar.

## `@local-network`

This will stop a feature or scenario running on a local machine. Use this tag if there's a network policy in place that prevents your local machine from accessing protected functionality.

**Before adding this tag, check if you could write a better test.** It's hard to maintain tests that can't be run locally, so only use this tag if there's no practical way to fix the access issue.

#!/usr/bin/env groovy

library("govuk")

node {
  govuk.buildProject(
    skipDeployToIntegration: true,
    overrideTestTask: {
      // No tests
    }
  )
}

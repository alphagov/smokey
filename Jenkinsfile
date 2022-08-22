#!/usr/bin/env groovy

library("govuk@add-smokey-deploy")

node {
  govuk.buildProject(
    repoName: 'smokey',
    overrideTestTask: {
      // No tests
    }
  )
}

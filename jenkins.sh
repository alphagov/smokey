#!/bin/sh

set -x

bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment

export RESTCLIENT_LOG="log/smokey-rest-client.log"
export ENVIRONMENT=${TARGET_PLATFORM}

govuk_setenv smokey bundle exec cucumber --profile ${TARGET_PLATFORM}

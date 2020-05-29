#!/bin/sh

set -x

if [ -z $MYTASK ]; then
  MYTASK="test:production"
fi

bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment
RESTCLIENT_LOG="log/smokey-rest-client.log" govuk_setenv smokey bundle exec rake $MYTASK

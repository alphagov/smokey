#!/bin/sh

set -x

if [ "$FACTER_govuk_provider" = "sky" ]; then
  MYTASK="test:skyscapenetwork"
else
  MYTASK="test:localnetwork"
fi

bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment --quiet
RESTCLIENT_LOG="log/smokey-rest-client.log" bundle exec rake $MYTASK

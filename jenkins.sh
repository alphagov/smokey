#!/bin/sh

set -x

if [ "$FACTER_govuk_provider" = "sky" ]; then
  MYTASK="test:skyscapenetwork"
else
  MYTASK="test:localnetwork"
fi

export GOVUK_APP_DOMAIN=test.gov.uk
export GOVUK_ASSET_ROOT=http://static.test.gov.uk
bundle install --path "${HOME}/bundles/${JOB_NAME}" --deployment --quiet
RESTCLIENT_LOG="log/smokey-rest-client.log" bundle exec rake $MYTASK

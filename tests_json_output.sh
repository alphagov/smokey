#!/bin/bash

# This file is used to run the Continuous Smokey loop.
# It runs Cucumber and dumps the output in JSON format
# to a temporary file for later processing by the Python
# script "nagios_check_cache.py".

# This LANG declaration is needed for Gherkin
# without it, we get "invalid byte sequence in US-ASCII" errors
# https://github.com/cucumber/gherkin#troubleshooting
export LANG=en_US.UTF-8

set -e

cd $(dirname "$0")

if [ "$1" == "" ]; then
  echo "Usage: ./tests_json_output.sh /tmp/smokey.json [environment]"
  exit 1
else
  FILE="$1"
fi

if [ -n "$2" ]; then
    PROFILE="--profile $2"
    ENVIRONMENT="$2"
else
    ENVIRONMENT="production"
fi

exec /usr/local/bin/govuk_setenv smokey \
    bundle exec cucumber ENVIRONMENT=${ENVIRONMENT} --expand --format json ${PROFILE:-} \
        --out "$FILE"

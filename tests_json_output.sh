#!/bin/bash

#  This LANG declaration is needed for Gherkin
#  without it, we get "invalid byte sequence in US-ASCII" errors
#  https://github.com/cucumber/gherkin#troubleshooting
export LANG=en_US.UTF-8

set -e

cd $(dirname "$0")

[ -e /etc/smokey.sh ] && . /etc/smokey.sh

if [ "$1" == "" ]; then
  echo "Usage: ./tests_json_output.sh /tmp/smokey.json [environment]"
  exit 1
else
  CACHE_FILE="$1"
fi

TMP_FILE="${CACHE_FILE}.tmp"

if [ -n "$2" ]; then
    PROFILE="--profile $2"
fi

GOVUK_SETENV_APP=default
if [ -n "$3" ]; then
  GOVUK_SETENV_APP=$3
fi

rm -f ${TMP_FILE}
/usr/local/bin/govuk_setenv $GOVUK_SETENV_APP \
    bundle exec cucumber --expand --format json ${PROFILE:-} \
        -t ~@disabled_in_icinga > ${TMP_FILE} || true
mv ${TMP_FILE} ${CACHE_FILE}

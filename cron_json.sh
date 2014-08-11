#!/bin/bash

#  This LANG declaration is needed for Gherkin
#  without it, we get "invalid byte sequence in US-ASCII" errors
#  https://github.com/cucumber/gherkin#troubleshooting
export LANG=en_US.UTF-8

set -e

cd $(dirname "$0")

[ -e /etc/smokey.sh ] && . /etc/smokey.sh

if [ "$1" == "" ]; then
  echo "Usage: ./cron_json.sh /tmp/smokey.json"
  exit 1
else
  CACHE_FILE="$1"
fi

TMP_FILE="${CACHE_FILE}.tmp"

rm -f ${TMP_FILE}
/usr/local/bin/govuk_setenv default \
    bundle exec cucumber --format json \
        -t ~@pending -t ~@notnagios > ${TMP_FILE} || true
mv ${TMP_FILE} ${CACHE_FILE}

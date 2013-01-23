#!/bin/sh

set -e

cd $(dirname "$0")

if [ $# -ne 2 ]; then
  echo "UNKNOWN: Usage: nagios_check_cache.sh feature <high|medium|low|unprio>"
  exit 3
fi

CHECKFILE="/tmp/smokey_${1}_${2}"

if [ ! -f "$CHECKFILE" ]; then
  echo "UNKNOWN: Cache file ${CHECKFILE} does not exist"
  exit 3
fi

if test $(find "$CHECKFILE" -mmin +30); then
  echo "UNKNOWN: Cache file ${CHECKFILE} last modified more than 30 minutes ago"
  exit 3
fi

fail_parse () {
  echo "UNKNOWN: Could not parse ${CHECKFILE}"
  exit 3
}

CHECKOUTPUT=$(cat $CHECKFILE)
CRITICAL=$(echo $CHECKOUTPUT | grep -Eo 'Critical: [0-9]+' | grep -Eo '[0-9]+') || fail_parse
WARNING=$(echo $CHECKOUTPUT | grep -Eo 'Warning: [0-9]+' | grep -Eo '[0-9]+') || fail_parse

if [ "$CRITICAL" -gt "0" ]; then
  echo "CRITICAL: ${CHECKOUTPUT}"
  exit 2
elif [ "$WARNING" -gt "0" ]; then
  echo "WARNING: ${CHECKOUTPUT}"
  exit 1
elif [ "$CRITICAL" -eq "0" -a "$WARNING" -eq "0" ]; then
  echo "OK: ${CHECKOUTPUT}"
  exit 0
else
  fail_parse
fi

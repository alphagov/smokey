#!/bin/bash
CACHE_FILE="$1"
TMP_FILE="${CACHE_FILE}.tmp"

rm -f ${TMP_FILE}
bundle exec cucumber --format json \
                     -t ~@pending -t ~@notnagios \
                     -t ~@notskyscape > ${TMP_FILE} || true
mv ${TMP_FILE} ${CACHE_FILE}

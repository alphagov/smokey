#!/bin/bash

set -e

CHECKFILE="/tmp/smokey_${1}_${2}"

if [ $# -ne 2 ]; then
   echo "UNKNOWN: Usage: ./nagios_check feature <high|medium|low|unprio>"
   exit 3
fi
if [ ! -f /tmp/smokey_${1}_${2} ]; then
   echo "UNKNOWN: Cache file $CHECKFILE does not exist"
   exit 3
fi

MTIME=`stat -c %Y "$CHECKFILE"`
NOW=`date +%s`
let AGE=NOW-MTIME
if [ $AGE -gt 1800 ]; then
  echo "UNKNOWN: Cache file $CHECKFILE older than 30mins ($AGE)"
  exit 3
fi

if [ -f /tmp/smokey_running_${1} ]; then
  echo "OK: Smokey run in progress"
  exit 0
fi

CHECKOUTPUT=`cat $CHECKFILE`
CRITICAL=`echo $CHECKOUTPUT | cut -d, -f1 | cut -d\  -f2 | sed 's/ //g' `
WARNING=`echo $CHECKOUTPUT | cut -d, -f2 | cut -d\  -f3 | sed 's/ //g'`
if [ "${CRITICAL}${WARNING}" != "00" ]; then
  CHECKOUTPUT=`bundle exec cucumber features/$1.feature --format Cucumber::Formatter::Nagios -t ~@pending -t ~@notskyscape -t ~@notnagios -t @${2}`
  CRITICAL=`echo $CHECKOUTPUT | cut -d, -f1 | cut -d\  -f2 | sed 's/ //g' `
  WARNING=`echo $CHECKOUTPUT | cut -d, -f2 | cut -d\  -f3 | sed 's/ //g'`
  if [ $CRITICAL -gt 0 ]; then
    echo "CRITICAL: $CHECKOUTPUT"
    exit 2 
  elif [ $WARNING -gt 0 ]; then
    echo "WARNING: $CHECKOUTPUT"
    exit 1 
  else
    echo "OK: $CHECKOUTPUT"
    exit 0 
  fi
else
  echo "OK: $CHECKOUTPUT"
  exit 0
fi

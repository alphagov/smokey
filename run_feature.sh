#!/bin/bash

set -e

tmpfeature=${1##*/}
feature=${tmpfeature%%.*}

if [ -f /tmp/smokey_running_${feature} ]; then
  echo "Smokey is already running"
  exit 1
fi

touch /tmp/smokey_running_${feature}

sleep $(($RANDOM/1000))

for priority in urgent high normal low; do
    tests=`grep -c "@${priority}" $1`
    if [ $tests -gt 0 ]; then
      cucumber $1 --format Cucumber::Formatter::Nagios -t ~@pending -t ~@notskyscape -t ~@notnagios -t @${priority} > /tmp/smokey_${feature}_${priority}
    else
      echo "Critical: 0, Warning: 0, 0 okay | No tests at this priority" >/tmp/smokey_${feature}_${priority}
    fi
done;

rm /tmp/smokey_running_${feature}

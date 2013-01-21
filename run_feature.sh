#!/bin/sh

set -e

if [ $# -ne 1 ]; then
  echo "Usage: run_feature.sh <path/to/foo.feature>" >&2
  exit 1
fi

feature=$(basename "$1" .feature)

for priority in urgent high normal low; do
  echo "Running feature '${feature}', ${priority} priority" >&2
  cucumber "$1" \
    --format Cucumber::Formatter::Nagios \
    -t ~@pending \
    -t ~@notnagios \
    -t ~@notskyscape \
    -t "@${priority}" |
  tee "/tmp/smokey_${feature}_${priority}"
done

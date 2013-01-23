#!/bin/sh

set -e

if [ $# -ne 1 ]; then
  echo "Usage: run_feature.sh <path/to/foo.feature>" >&2
  exit 1
fi

feature_file=$1
feature=$(basename "$feature_file" .feature)

run_cucumber () {
  local feat=$1
  local prio=$2
  cucumber "$feat" \
    --format Cucumber::Formatter::Nagios \
    -t ~@pending \
    -t ~@notnagios \
    -t ~@notskyscape \
    -t "@${prio}" || true # Don't mind if cucumber exits abnormally
}

for priority in urgent high normal low; do
  echo "Running feature '${feature}', ${priority} priority" >&2

  # First capture the result, then write to the cache file. This minimizes the
  # amount of time that the file is empty, thus preventing Nagios "(null)"
  # statuses.
  RESULT=$(run_cucumber "$feature_file" "$priority")
  echo "$RESULT" | tee "/tmp/smokey_${feature}_${priority}"
done

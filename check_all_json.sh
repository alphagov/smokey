#!/bin/bash
# Checks smokey json output for all features
# Usage ./check_all_json.sh /tmp/smokey.json

for featurefile in `ls features/*.feature`; do
  feature=${featurefile%%.feature}
  feature=${feature##features/}
  for priority in urgent high medium low; do
  echo -n "$feature/$priority: "
    ./nagios_check_cache.py $feature $priority $1
  done
done

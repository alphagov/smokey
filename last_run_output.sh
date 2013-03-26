#!/bin/bash
# Given a log directory, a feature and a priority, this will output the
#   log of the last smokey run.
#
# Usage: last_run_output.sh /opt/smokey/log/ whitehall normal
#
LOGDIR=$1
FEATURE=$2
PRIORITY=$3

LOGFILE="${LOGDIR}/${FEATURE}_${PRIORITY}.log"

LOGTIME=`tail -n1 $LOGFILE | cut -d: -f1-3`
grep --color=never "${LOGTIME}" $LOGFILE

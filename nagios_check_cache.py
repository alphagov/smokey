#!/usr/bin/env python
import json, sys, os
from pprint import pprint
from time import gmtime, strftime
json_data=open("tests/fixtures/smokey.json").read()
data = json.loads(json_data)
priority = "@" + sys.argv[2]
feature_name  = sys.argv[1]
feature_uri = 'features/' + feature_name + '.feature'
feature_found = False
logfile = 'log/' + feature_name + '_' + sys.argv[2] + '.log'
logdir = os.path.dirname(logfile)
if not os.path.exists(logdir):
  os.makedirs(logdir)

fh = open(logfile,"a")

for feature in data:
  if feature['uri'] == feature_uri:
    feature_found = True
    fh.write("%s: Feature: %s\n" % (strftime("%Y-%m-%d %H:%M:%S", gmtime()),feature['uri']))
    passed  = 0
    skipped = 0
    failed  = 0
    failed_tests = ""
    for scenario in feature['elements']:
      fh.write("%s:  Scenario: %s\n" % (strftime("%Y-%m-%d %H:%M:%S", gmtime()),scenario['name']))
      if 'tags' in scenario:
        for tag in scenario['tags']:
          if tag['name'] == priority:
            for step in scenario['steps']:
              if step['result']['status'] == 'passed':
                passed += 1
              elif step['result']['status'] == 'skipped':
                skipped += 1
              else:
                failed += 1
              fh.write("%s:    Step: %s - %s\n" % ( strftime("%Y-%m-%d %H:%M:%S", gmtime()),step['name'], step['result']['status'] ))
    if failed > 0: 
      status = "CRITICAL"
      exitcode = 2
    elif skipped > 0:
      status = "WARNING"
      exitcode = 1
    elif passed > 0:
      status = "OK"
      exitcode = 0
    else:
      exitcode = 99
    if exitcode != 99:
      print "%s: %s failed, %s skipped, %s passed" % ( status, failed, skipped, passed )
      sys.exit(exitcode)
if feature_found:
  print "OK: no %s tests for %s found" % (priority, feature_name)
  sys.exit(0)
else:
  print "OK: Feature %s not found" % (feature_name)
  sys.exit(0)

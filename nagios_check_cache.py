#!/usr/bin/env python
import json, sys, os, codecs
from pprint import pprint
from time import gmtime, strftime, time

smokeydir = os.path.dirname(os.path.abspath(sys.argv[0]))
logdir = smokeydir + '/log/'

# Exit if usage is wrong
if len(sys.argv) != 4:
  print "UNKNOWN: Usage: nagios_check_cache.py feature priority jsonfile"
  sys.exit(2)

# Check whether the json file exists and issue UNKNOWN if not
jsonfile = sys.argv[3]
if os.path.exists(jsonfile) == False:
  print "UNKNOWN: %s does not exist" % jsonfile
  sys.exit(2)

# Check the age of the json file is less than 30m and issue UNKNOWN if not
json_age = time() - os.stat(jsonfile).st_mtime
if json_age > 1800:
  print "UNKNOWN: %s is older than 30m" % jsonfile
  sys.exit(2)

# Parse the json and set some variables
json_data = open(jsonfile).read()
data = json.loads(json_data)
priority = "@" + sys.argv[2]
feature_name  = sys.argv[1]
feature_uri = 'features/' + feature_name + '.feature'
feature_found = False
logfile = logdir + feature_name + '_' + sys.argv[2] + '.log'
runtime = strftime("%Y-%m-%d %H:%M:%S", gmtime())

# Check the log directory exists and open the logfile
if not os.path.exists(logdir):
  os.makedirs(logdir)

# Walk the json tree of features
for feature in data:
  if feature['uri'] == feature_uri:
    # Yay, we have found the right feature
    feature_found = True
    passed  = 0
    skipped = 0
    failed  = 0
    failed_tests = ""
    # Walk through the scenarios in the feature
    if 'elements' not in feature:
      print "OK: Feature %s has no steps at any priority" % (feature_name)
      sys.exit(0)
    for scenario in feature['elements']:
      if 'tags' in scenario:
        for tag in scenario['tags']:
          # If the scenario matches our tag, then check the output
          if tag['name'] == priority:
            # Only open the logfile if we are going to write to it
            fh = codecs.open(logfile,"a","utf-8-sig")
            # Write out a header to our log
            fh.write("%s:  Scenario: %s (%s/%s)\n" % (runtime,scenario['name'],feature['uri'], priority))
            for step in scenario['steps']:
              message = ""
              if step['result']['status'] == 'passed':
                passed += 1
              elif step['result']['status'] == 'skipped':
                skipped += 1
              else:
                failed += 1
                # Only failures have messages
                message = step['result']['error_message']
              # Write out the step description and the status
              fh.write("%s:    Step: [%s] %s%s\n" % (runtime,step['result']['status'].upper()[:4],step['keyword'],step['name']))
              # If we have any rows (e.g. perhaps lists of URLs to visit, write them too)
              if 'rows' in step:
                for row in step['rows']:
                  fh.write("%s:              " % runtime)
                  for cell in row['cells']:
                    fh.write("%s " % cell)
                  fh.write("\n")
              # If we encountered a failure, write out the error
              if message != "":
                fh.write("%s:      Error: %s\n" % (runtime,message.partition('\n')[0]))
            # A blank line to make our log pretty
            fh.write("%s:\n" % runtime)
            fh.close()

# We didn't even find this feature in the steps!
if not feature_found:
  print "OK: But feature %s was not found" % (feature_name)
  sys.exit(0)

# Check the output of our tests
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
  # We use this exitcode later
  exitcode = 99

# Assuming we had a non-zero number of checks, lets spit out Nagios output
if exitcode != 99:
  print "%s: %s failed, %s skipped, %s passed; see %s for more details" % ( status, failed, skipped, passed, logfile)
  sys.exit(exitcode)

# We had no steps, but did the feature at least exist?
if feature_found:
  print "OK: But no %s tests for %s found" % (priority, feature_name)
  sys.exit(0)
else:
  print "UNKNOWN: Something went very wrong"
  sys.exit(3)

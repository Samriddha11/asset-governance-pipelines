#!/bin/bash

# Capture Harness pipeline variables
account_id="<+pipeline.variables.account_id>"
region="<+pipeline.variables.region>"
resource="<+pipeline.variables.resource>"

echo "*****Show Account*****"
echo "$account_id"
echo "******END*****"
echo "*****Show Region*****"
echo "$region"
echo "******END*****"

echo "*****Show resources*****"
echo "$resource"
echo "******END*****"

# The resource is not strictly valid JSON. We attempt to convert it into valid JSON.
# This example assumes the structure remains consistent.
# Variables

email_content=$(echo "$resource" | \
  sed -e 's/^{volumes:\[\[{//' -e 's/}\]\]}$//' | \
  sed 's/},{/\n/g' | \
  grep -v '^[[:space:]]*$' | \
  awk -F, -v tz="America/New_York" -v account_id="$account_id" '
    BEGIN {
      print "<html><head><title>AWS Unattached EBS Volumes</title>"
      print "<style>"
      print "body { font-family: Arial, sans-serif; margin: 20px; }"
      print "h2 { color: blue; font-size: 22px; }"
      print "table { width: 90%; border-collapse: collapse; margin-top: 20px; border: 2px solid black; }"
      print "th, td { padding: 12px; border: 2px solid black; text-align: left; font-size: 14px; }"
      print "th { background-color: #444; color: white; font-size: 16px; font-weight: bold; }"
      print "tr:nth-child(even) { background-color: #f9f9f9; }"
      print "tr:hover { background-color: #f1f1f1; }"
      print ".account-info { font-size: 18px; font-weight: bold; margin-top: 10px; }"
      print "</style></head><body>"

      print "<h2>AWS Unattached EBS Volumes In Your Account</h2>"
      print "<p style=\"font-size:14px; color:#555;\">The following EBS volumes are not attached to any EC2 instances. Please provide your approval to mark them for deletion in the future:</p>"

      print "<p class=\"account-info\">AWS Account: " account_id "</p>"
    }
    {
      vol_id=""
      create_time=""
      owner="N/A"  # Default value
      tags=""

      for (i=1; i<=NF; i++) {
        if ($i ~ /VolumeId:/) { vol_id=substr($i,index($i,":")+1) }
        if ($i ~ /CreateTime:/) { create_time=substr($i,index($i,":")+1) }
        if ($i ~ /Tags:/) { tags=$i }  # Capture full Tags field
      }

      # Extract Owner directly
      if (match(tags, /Key:Owner,Value:([^}]*)/, owner_match)) {
        owner = owner_match[1]
      }

      if (vol_id != "") {
        cmd="TZ=" tz " date -d \"" create_time "\" +\"%Y-%m-%d %H:%M:%S %Z\""
        cmd | getline est_time
        close(cmd)

        rows = rows "<tr>"
        rows = rows "<td>" vol_id "</td>"
        rows = rows "<td>" owner "</td>"
        rows = rows "<td>" est_time "</td></tr>\n"
      }
    }
    END {
      print "<table border=\"2\">"  # Ensure border is always visible in emails
      print "<tr><th>Volume ID</th><th>Owner</th><th>Create Time (EST)</th></tr>"
      print rows
      print "</table>"
      print "</body></html>"
    }
  '
)

export $email_content
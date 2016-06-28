#!/bin/sh
while [ true ]; do
  timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  host=$(hostname)
  ping=$(ping -c 5 www.google.com | tail -1 | awk -F '/' '{print $5}')
  echo "timestamp_dt,hostname_s,metric_s,value_f" > ping.csv
  echo "$timestamp,$host,ping,$ping" >> ping.csv
  post -c stats -p 9000 ping.csv
  rm ping.csv
  sleep 5
done

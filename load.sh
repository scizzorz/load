#!/bin/sh

while [ true ]; do

  timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
  host=$(hostname)
  load=$(cat /proc/loadavg)
  one=$(echo $load | awk '{print $1}')
  five=$(echo $load | awk '{print $2}')
  fifteen=$(echo $load | awk '{print $3}')
  ram=$(free | grep Mem | awk '{print $3/$2}')

  echo "timestamp_dt,hostname_s,metric_s,value_f" > stats.csv
  echo "$timestamp,$host,one,$one" >> stats.csv
  echo "$timestamp,$host,five,$five" >> stats.csv
  echo "$timestamp,$host,fifteen,$fifteen" >> stats.csv
  echo "$timestamp,$host,ram,$ram" >> stats.csv

  post -c stats -p 9000 stats.csv
  rm stats.csv
  sleep 15

done

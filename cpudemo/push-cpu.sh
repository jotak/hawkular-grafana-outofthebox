#!/bin/sh

trap 'exit 0' SIGTERM

until curl -u jdoe:password http://hawkular:8080/hawkular/metrics
do
  sleep 5
done

echo "Starting CPU-push script"
while :
do
  loadavg=`awk '{ print $1 }' /proc/loadavg`
  ux_timestamp=`date +%s`
  timestamp=$(($ux_timestamp * 1000))
  curl -u jdoe:password -X POST http://hawkular:8080/hawkular/metrics/gauges/load-avg/raw \
    -d "[{\"timestamp\": $timestamp, \"value\": $loadavg}]" \
    -H "Content-Type: application/json" -H "Hawkular-Tenant: $TENANT"
  sleep 10
done

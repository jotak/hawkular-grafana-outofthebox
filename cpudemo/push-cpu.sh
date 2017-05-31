#!/bin/sh

trap 'exit 0' SIGTERM

until curl -u jdoe:password http://hawkular:8080/hawkular/metrics
do
  sleep 5
done

echo "Starting CPU-push script"
while :
do
  cpu=`top -bn1 | grep load | awk -F', |: ' '{printf $(NF-2)}'`
  ux_timestamp=`date +%s`
  timestamp=$(($ux_timestamp * 1000))
  curl -u jdoe:password -X POST http://hawkular:8080/hawkular/metrics/gauges/load-avg/raw \
    -d "[{\"timestamp\": $timestamp, \"value\": $cpu}]" \
    -H "Content-Type: application/json" -H "Hawkular-Tenant: $TENANT"
  sleep 10
done

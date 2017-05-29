#!/bin/sh

echo "Available dashboards:"
ls *.json

until curl -u admin:admin http://grafana:3000/api/datasources
do
  sleep 0.5
done

echo "Creating hawkular datasource for tenant $TENANT"
sed -i "s/\$TENANT/$TENANT/g" new-datasource.json

curl -u admin:admin -H "Content-Type: application/json" -X POST -d @new-datasource.json http://grafana:3000/api/datasources

for dashboard in ${DASHBOARDS}; do
    echo "Importing dashboard $dashboard"
    sed -i "s/\$TENANT/$TENANT/g" $dashboard.json
    curl -u admin:admin -H "Content-Type: application/json" -X POST -d @$dashboard.json http://grafana:3000/api/dashboards/db
done

#!/bin/sh

echo "Available dashboards:"
ls *.json

until curl -u admin:admin http://grafana:3000/api/datasources
do
  sleep 0.5
done

echo "Creating hawkular datasource for tenant $TENANT"
sed -e "s/\$TENANT/$TENANT/g" new-datasource.json > new-datasource-edited.json

curl -u admin:admin -H "Content-Type: application/json" -X POST -d @new-datasource-edited.json http://grafana:3000/api/datasources

for dashboard in ${DASHBOARDS}; do
    echo "Importing dashboard $dashboard"
    sed -e "s/\$TENANT/$TENANT/g" $dashboard.json > $dashboard-edited.json
    curl -u admin:admin -H "Content-Type: application/json" -X POST -d @$dashboard-edited.json http://grafana:3000/api/dashboards/db
done

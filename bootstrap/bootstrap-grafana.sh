#!/bin/sh

echo "Available dashboards:"
ls *.json

until curl -u admin:admin http://grafana:3000/api/datasources
do
  sleep 0.5
done

echo "Creating hawkular datasource for tenant $TENANT"
if [ $HAWKULAR_AUTH_TOKEN ]
then
  sed -e "s/\$TENANT/$TENANT/g" -e "s|\$HAWKULAR_URI|$HAWKULAR_URI|g" -e "s/\$HAWKULAR_AUTH_TOKEN/$HAWKULAR_AUTH_TOKEN/g" datasource-token.json > datasource-edited.json
else
  sed -e "s/\$TENANT/$TENANT/g" -e "s|\$HAWKULAR_URI|$HAWKULAR_URI|g" datasource-basicauth.json > datasource-edited.json
fi

curl -u admin:admin -H "Content-Type: application/json" -X POST -d @datasource-edited.json http://grafana:3000/api/datasources

for dashboard in ${DASHBOARDS}; do
    echo "Importing dashboard $dashboard"
    sed -e "s/\$TENANT/$TENANT/g" $dashboard.json > $dashboard-edited.json
    curl -u admin:admin -H "Content-Type: application/json" -X POST -d @$dashboard-edited.json http://grafana:3000/api/dashboards/db
done

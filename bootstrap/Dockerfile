FROM centos:7

ENV HAWKULAR_URI http://hawkular:8080/hawkular/metrics

ADD ./bootstrap-grafana.sh /tmp/bootstrap-grafana.sh
ADD ./datasource-basicauth.json /tmp/datasource-basicauth.json
ADD ./datasource-token.json /tmp/datasource-token.json

RUN chmod +x /tmp/bootstrap-grafana.sh
WORKDIR /tmp

ADD ./dashboards/* /tmp/

ENTRYPOINT ["/tmp/bootstrap-grafana.sh"]

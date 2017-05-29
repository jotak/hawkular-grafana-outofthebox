FROM centos:7

ADD ./bootstrap-grafana.sh /tmp/bootstrap-grafana.sh
ADD ./new-datasource.json /tmp/new-datasource.json

RUN chmod +x /tmp/bootstrap-grafana.sh
WORKDIR /tmp

ADD ./dashboards/* /tmp/

ENTRYPOINT ["/tmp/bootstrap-grafana.sh"]

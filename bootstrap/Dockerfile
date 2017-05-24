FROM centos:7

ADD ./bootstrap-grafana.sh /tmp/bootstrap-grafana.sh
ADD ./new-datasource.json /tmp/new-datasource.json
ADD ./dashboards/* /tmp/

RUN chmod +x /tmp/bootstrap-grafana.sh

RUN ls -al /tmp
WORKDIR /tmp

ENTRYPOINT ["/tmp/bootstrap-grafana.sh"]

FROM centos:7

ADD ./push-cpu.sh /tmp/push-cpu.sh

RUN chmod +x /tmp/push-cpu.sh

ENTRYPOINT ["/tmp/push-cpu.sh"]

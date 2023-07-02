FROM amd64/ubuntu:23.10

ENV SETUP=/entrypoint.d/setup.sh

RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list && \
  apt update && apt install -y tzdata net-tools iproute2 traceroute dnsutils sudo cron logrotate rsyslog tar gzip && \
  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  apt-get clean

ADD --chmod=755 entrypoint.d /entrypoint.d

VOLUME [ "/var/log/rsyslog", "/var/lib/logrotate", "/run", "/etc/rsyslog.d", "/etc/logrotate.d" ]

RUN ${SETUP} && rm -rf ${SETUP}

EXPOSE 1514

HEALTHCHECK CMD netstat -aptun | grep 1514

CMD [ "entrypoint.sh" ]

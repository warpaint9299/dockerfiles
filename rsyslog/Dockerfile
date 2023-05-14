FROM alpine:3.18

ENV SETUP=/entrypoint.d/setup.sh

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
  apk --no-cache update && apk --no-cache add sudo shadow cronie logrotate rsyslog tar gzip tzdata && \
  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  groupadd -r -g 1000 w && useradd --no-log-init -r -m -g 1000 -u 1000 w

ADD --chmod=755 entrypoint.d /entrypoint.d

VOLUME [ "/var/log/rsyslog", "/var/lib/logrotate", "/run", "/etc/rsyslog.d", "/etc/logrotate.d" ]

RUN ${SETUP} && rm -rf ${SETUP}

EXPOSE 1514

HEALTHCHECK CMD netstat -aptun | grep 1514

CMD [ "entrypoint.sh" ]

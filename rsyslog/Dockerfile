FROM alpine:3.18 AS wlog

WORKDIR /entrypoint.d

VOLUME [ "/var/log/rsyslog", "/var/lib/logrotate", "/run", "/etc/rsyslog.d", "/etc/logrotate.d" ]

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
  apk --no-cache update && apk --no-cache add sudo shadow cronie logrotate rsyslog tar gzip && \
  groupadd -r -g 1000 w && useradd --no-log-init -r -m -g 1000 -u 1000 w

RUN rm -rf /etc/logrotate.d/

COPY --chmod=744 rsyslog.conf /etc/rsyslog.conf
COPY --chmod=744 rsyslog-docker.conf /etc/rsyslog.d/rsyslog-docker.conf
COPY --chmod=744 logrotate-docker.conf /etc/logrotate.d/logrotate-docker.conf
COPY --chmod=744 logrotate /etc/periodic/daily/logrotate
COPY --chmod=744 entrypoint.sh /usr/local/bin

HEALTHCHECK CMD netstat -aptun | grep 1514

CMD [ "entrypoint.sh" ]

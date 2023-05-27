FROM erlang:24.3.3.0-alpine

ENV RABBITMQ_HOME=/home/rabbitmq \
  RABBITMQ_DEFAULT_USER=guest \
  RABBITMQ_DEFAULT_PASS=guest \
  RABBITMQ_MASTER_HOSTNAME=rabbitmq01 \
  RABBITMQ_ENABLE_CLUSTER=false \
  RABBITMQ_CLUSTER_TYPE=ram \
  RABBITMQ_ERLANG_COOKIE='' \
  RABBITMQ_AWAIT_SECOND=1 \
  SETUP=/entrypoint.d/setup.sh \
  RABBITMQ_VERSION=3.9.14

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
  apk --no-cache update && apk --no-cache add sudo shadow tar gzip xz tzdata && \
  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  groupadd -r -g 1000 rabbitmq && useradd --no-log-init -r -m -g 1000 -u 1000 rabbitmq

ADD --chmod=755 entrypoint.d /entrypoint.d

VOLUME [ "${RABBITMQ_HOME}/var/lib/rabbitmq", "${RABBITMQ_HOME}/var/log/rabbitmq" ]

RUN ${SETUP} && rm -rf ${SETUP}

EXPOSE 5672 15672 4369

HEALTHCHECK CMD netstat -aptun | grep 5672

CMD [ "entrypoint.sh"]

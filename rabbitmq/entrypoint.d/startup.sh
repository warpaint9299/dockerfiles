#!/usr/bin/env sh

set -eux

export PATH=/usr/local/bin:$PATH
echo ${RABBITMQ_ERLANG_COOKIE:-$(head -c 8 /dev/random | od -An -t x | tr -d ' ')} > ${RABBITMQ_HOME}/.erlang.cookie
chmod 600 ${RABBITMQ_HOME}/.erlang.cookie
sed -i "s/##RABBITMQ_DEFAULT_USER##/${RABBITMQ_DEFAULT_USER}/g;s/##RABBITMQ_DEFAULT_PASS##/${RABBITMQ_DEFAULT_PASS}/g" ${RABBITMQ_HOME}/etc/rabbitmq/rabbitmq.conf

rabbitmq-plugins enable rabbitmq_management

if [[ $(hostname) != ${RABBITMQ_MASTER_HOSTNAME} && ${RABBITMQ_ENABLE_CLUSTER} == 'true' ]]; then
 rabbitmq-server &
 sleep ${RABBITMQ_AWAIT_SECOND}
 rabbitmqctl stop_app && \
 rabbitmqctl reset
  if [[ ${RABBITMQ_CLUSTER_TYPE} == 'ram' ]]; then
      rabbitmqctl --ram join_cluster rabbit@${RABBITMQ_MASTER_HOSTNAME}
  else
      rabbitmqctl --disc join_cluster rabbit@${RABBITMQ_MASTER_HOSTNAME}
  fi
  rabbitmqctl start_app && \
  rabbitmqctl set_policy ha-all "^" '{"ha-mode":"all"}' && \
  rabbitmqctl stop
fi

rabbitmq-server

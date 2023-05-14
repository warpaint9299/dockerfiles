#!/usr/bin/env sh

set -eux
export PATH=/usr/local/bin:$PATH

chown -R 1000:1000 ${RABBITMQ_HOME}
su -c '/entrypoint.d/startup.sh' rabbitmq

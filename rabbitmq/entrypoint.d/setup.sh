#!/usr/bin/env sh

set -eux

cd /entrypoint.d
tar -xvf ${RABBITMQ_PKG} --strip-components 1 -C ${RABBITMQ_HOME}
rm -rf ${RABBITMQ_PKG}

mv rabbitmq.conf ${RABBITMQ_HOME}/etc/rabbitmq
chown -R 1000:1000 ${RABBITMQ_HOME}

cd ${RABBITMQ_HOME}/sbin
for i in $(ls -1); do ln -s ${RABBITMQ_HOME}/sbin/$i /usr/local/bin/$i; done
cd /usr/local/bin
for i in $(ls -1); do ln -s /usr/local/bin/$i /usr/bin/$i; done

ln -sf /entrypoint.d/entrypoint.sh /usr/local/bin/entrypoint.sh
set +eux
exit 0

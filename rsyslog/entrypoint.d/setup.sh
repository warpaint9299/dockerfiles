#!/usr/bin/env sh

cd /entrypoint.d
mkdir /etc/rsyslog.d
mv rsyslog.conf /etc/rsyslog.conf
mv rsyslog-docker.conf /etc/rsyslog.d/rsyslog-docker.conf
mv logrotate-docker.conf /etc/logrotate.d/logrotate-docker.conf
mv logrotate /etc/periodic/daily/logrotate 
ln -s /entrypoint.d/entrypoint.sh /usr/local/bin/entrypoint.sh
exit 0

#!/usr/bin/env sh

rm -rf /run/rsyslogd.pid
chown 1000:1000 /etc/logrotate.d
chown 1000:1000 /var/lib/logrotate
chown 1000:1000 /etc/rsyslog.d
chown 1000:1000 /var/log/rsyslog
chown -R 1000:1000 /run
crond
sudo --user \#1000 -E 'rsyslogd' '-dn'

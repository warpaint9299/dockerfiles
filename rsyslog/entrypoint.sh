#!/usr/bin/env sh

chown 1000:1000 /etc/logrotate.d
chown 1000:1000 /var/lib/logrotate
chown 1000:1000 /etc/rsyslog.d
chown 1000:1000 /var/log/rsyslog
chown 1000:1000 /run
#rm -rf /etc/periodic/daily/logrotate
crond
sudo --user \#1000 -E 'rsyslogd' '-dn'

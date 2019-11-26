#!/bin/bash
#/etc/init.d/ser2net stop
echo "Create config file"
cat << eof > /etc/ser2net.conf
$TTY_CAT_PORT:telnet:600:$TTY_CAT:$TTY_CAT_CONF
$TTY_PTT_PORT:telnet:600:$TTY_PTT:$TTY_PTT_CONF
eof
#/etc/init.d/ser2net start
ser2net -d

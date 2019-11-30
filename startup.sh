#!/bin/bash
set -e

echo "Create config file"
cat << eof > /etc/ser2net.conf
$TTY_CAT_PORT:telnet:600:$TTY_CAT:$TTY_CAT_CONF
$TTY_CAT_PORT2:telnet:600:$TTY_CAT:$TTY_CAT_CONF
$TTY_PTT_PORT:telnet:600:$TTY_PTT:$TTY_PTT_CONF
eof
#FIXME: PTT Port as RTS raw?

echo "Start source CAT port"
ser2net -d &


echo "Configure Pulseaudio"
#FIXME: address as environment
#FIXME: check for multicast - multiple remote sinks
cat << eof >> /etc/pulse/default.pa
load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;10.101.10.53;10.101.10.1;
load-module module-zeroconf-publish
load-module module-alsa-source device=hw:1,0 source_name=Source
load-module module-alsa-sink device=hw:1,0 sink_name=Sink
set-default-sink Sink
set-default-source Source
eof
#FIXME: Multicast? https://unix.stackexchange.com/questions/471222/pulseaudio-rtp-multicast-how-to-play-sound-on-sender-too

pulseaudio --start

exec "$@"


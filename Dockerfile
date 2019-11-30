FROM debian 

MAINTAINER Gerolf Ziegenhain "gerolf.ziegenhain@gmail.com"

RUN apt-get update
RUN apt-get -y install ser2net 
RUN apt-get -y install net-tools
RUN apt-get -y install pulseaudio 
RUN apt-get -y install libhamlib-utils
RUN apt-get -qqy autoclean && rm -rf /tmp/* /var/tmp/*

# Default configuration of ports
ENV TTY_PTT /dev/ttyUSB0
ENV TTY_CAT /dev/ttyUSB1

# FIXME: Insert Label for TRX Type

# Configured for VX 1700
ENV TTY_CAT_CONF "4800 8DATABITS NONE 2STOPBITS"
ENV TTY_CAT_PORT "3002"
ENV TTY_CAT_PORT2 "3005"
ENV TTY_PTT_CONF "4800 8DATABITS NONE 2STOPBITS"
ENV TTY_PTT_PORT "3003"




EXPOSE 3002
EXPOSE 3003
EXPOSE 3005
# Pulseaudio
EXPOSE 4713
# Hamlib
EXPOSE 4532 

#FIXME: port range with multiple ports?

# FIXME: maybe a more useful check?
HEALTHCHECK --interval=10s --timeout=3s CMD netstat -na|grep 3002&&netstat -na|grep 3003&&netstat -na|grep 3005&&netstat -na|grep 4713||exit 1

ADD startup.sh /bin

ENTRYPOINT ["startup.sh"]
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"


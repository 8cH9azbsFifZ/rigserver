FROM debian 
#:buster-slim

MAINTAINER Gerolf Ziegenhain "gerolf.ziegenhain@gmail.com"

RUN apt-get update
RUN apt-get -y install ser2net 
RUN apt-get -y install net-tools
RUN apt-get -y install pulseaudio 
#pulseaudio-module-zeroconf avahi-daemon dbus-x11 --fix-missing
#RUN apt-get -y install paprefs
RUN apt-get -qqy autoclean && rm -rf /tmp/* /var/tmp/*

ENV TTY_CAT /dev/ttyUSB1
ENV TTY_CAT_CONF "4800 8DATABITS NONE 2STOPBITS"
ENV TTY_CAT_PORT "3002"
ENV TTY_CAT_PORT2 "3005"
ENV TTY_PTT /dev/ttyUSB0
ENV TTY_PTT_CONF "4800 8DATABITS NONE 2STOPBITS"
ENV TTY_PTT_PORT "3003"

ADD startup.sh /bin
EXPOSE 3002
EXPOSE 3003
EXPOSE 3005

HEALTHCHECK --interval=10s --timeout=3s CMD netstat -na|grep 3002&&netstat -na|grep 3003&&netstat -na|grep 3005||exit 1

#RUN apt-get -y install mumble-server

ENTRYPOINT ["startup.sh"]
CMD ["bash"]

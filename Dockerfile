FROM debian:buster-slim

MAINTAINER Gerolf Ziegenhain "gerolf.ziegenhain@gmail.com"

RUN apt-get update
RUN apt-get -y install ser2net socat
RUN apt-get -qqy autoclean && rm -rf /tmp/* /var/tmp/*

ENV TTY_CAT /dev/ttyUSB1
ENV TTY_CAT_CONF "4800 8DATABITS NONE 2STOPBITS"
ENV TTY_CAT_PORT "3002"
ENV TTY_PTT /dev/ttyUSB0
ENV TTY_PTT_CONF "4800 8DATABITS NONE 2STOPBITS"
ENV TTY_PTT_PORT "3003"

ADD startup.sh /bin
EXPOSE 3002
EXPOSE 3003

CMD ["startup.sh"]


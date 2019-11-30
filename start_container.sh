#!/bin/bash

TTY_CAT=/dev/$(dmesg|grep FTDI |tail -n1|sed 's/.* //g')
TTY_PTT=/dev/$(dmesg|grep pl2303|tail -n1|sed 's/.* //g')

docker run --rm --env TTY_PTT=$TTY_PTT --env TTY_PTT=$TTY_PTT --device=/dev/snd --device=$TTY_PTT --device=$TTY_CAT -it -e 3003:3003 -e 3002:3002 -e 3005:3005 -p 4713:4713 asdlfkj31h/rigserver:0.3

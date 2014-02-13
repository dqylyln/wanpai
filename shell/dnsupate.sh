#!/bin/bash
DNSPOD=`ps -ef|grep "bin/dnspod"|grep -v "grep"|wc -l`

if [ "${DNSPOD}" == "0" ]; then
  /home/pi/bin/dnspod > /home/pi/bin/data/dnspod.json 2>&1 &
fi

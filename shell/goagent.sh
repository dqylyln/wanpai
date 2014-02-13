#!/bin/bash
GOAGENT=`ps -ef|grep "goagent/local/proxy.py" |grep -v grep |wc -l`

if [ "${GOAGENT}" == "0" ]; then
	python /home/pi/goagent/local/proxy.py > /dev/null 2>&1 &
fi

#!/bin/bash

ACTION=$1
ENV_TAB=$2

SSH_PID=`ps -ef|grep "sshpass"| grep -- "-qTnN -D" | awk '{ print $2 }'`

case "${ACTION}" in
start)
        if [ "" == "${SSH_PID}" ]; then
                if [ "home" == "${ENV_TAB}" ]; then
                    ssh -qTfnN -D 7000 pi@dqy.me
                else
                    sshpass -p 'passwd' ssh -p 7655 -C -g -qTnN -D 7000 user@host > /dev/null 2>&1 &
                fi
                SSH_PID=`ps -ef|grep "sshpass"| grep -- "-qTnN -D" | awk '{ print $2 }'`
        fi
                echo "==== Start SSH Proxy PID is ${SSH_PID}! ===="
        ;;
status)
        if [ "" == "${SSH_PID}" ]; then
                echo "==== Not Found SSH Proxy Running! ===="
        else
                echo "==== Running SSH Proxy PID is ${SSH_PID}! ===="
        fi
        ;;
stop)
        echo "${SSH_PID}" | xargs kill
        echo "==== Stop SSH Proxy PID is ${SSH_PID}! ===="
        ;;
esac

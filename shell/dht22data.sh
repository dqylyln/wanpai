#!/bin/bash

SYS_DATA="`ps -ef|grep "DHT22"|grep -v "grep"|wc -l`"

if [ "${SYS_DATA}" != "0" ]; then
   echo "NOW RUNNING ${SYS_DATA}"   
 exit
fi

LOCATION="/home/pi/bin"
API_KEY=""
FEED_ID=""

COSM_JSON="${LOCATION}/data/dht22.json"
COSM_URL=https://api.xively.com/v2/feeds/${FEED_ID}?timezone=+8

TH_STAR=`${LOCATION}/DHT22`
i_temp=`echo $TH_STAR | awk '{print $1}'`
i_hum=`echo $TH_STAR | awk '{print $2}'`

STR=`awk 'BEGIN{ printf "{\"datastreams\":[{\"id\":\"i_temp\",\"current_value\":\"%.2f\"},{\"id\":\"i_hum\",\"current_value\":\"%.2f\"}] } ",'$i_temp','$i_hum'}'`

echo "===================${STR}==========================="
echo ${STR} > ${COSM_JSON}

curl -s -v --request PUT --header "X-ApiKey: ${API_KEY}" --data-binary @${COSM_JSON} ${COSM_URL}

#!/bin/bash

#SYS_DATA="`ps -ef|grep "DHT22"|grep -v "grep"|wc -l`"
#if [ "${SYS_DATA}" != "0" ]; then
#   echo "NOW RUNNING ${SYS_DATA}"   
# exit
#fi

LOCATION="/home/pi/bin"
API_KEY=""
FEED_ID=""

COSM_JSON="${LOCATION}/data/sysdata.json"
COSM_URL=https://api.xively.com/v2/feeds/${FEED_ID}?timezone=+8

eval `tsar --cpu --rpi --load --check | awk '{print $8,$10,$14}' | sed -e 's/:/_/g' | sed -e 's/ /\n/g'`

STR=`awk 'BEGIN{ printf "{\"datastreams\":[ {\"id\":\"load\",\"current_value\":\"%.2f\"},{\"id\":\"util\",\"current_value\":\"%.2f\"}, {\"id\":\"temp\",\"current_value\":\"%.2f\"}]} ",'$load_load5','$cpu_util','$rpi_temp'}'`

echo "===================${STR}==========================="
echo ${STR} > ${COSM_JSON}

curl -s -v --request PUT --header "X-ApiKey: ${API_KEY}" --data-binary @${COSM_JSON} ${COSM_URL}

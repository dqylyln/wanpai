#!/bin/bash
LOCATION='/home/pi/sysdata'
API_KEY=''
FEED_ID=''

COSM_URL=https://api.xively.com/v2/feeds/${FEED_ID}?timezone=+8
cpu_load=`cat /proc/loadavg | awk '{print $2}'`
for i in 1 2 3 4 5; do
        cpu_t=`cat /sys/class/thermal/thermal_zone0/temp | awk '{print $1/1000}'`
        if [[ "${cpu_t}" =~ ^- ]]
        then
                cpu_t='0.0'
        else
                break
        fi
done

TH_STAR=`/home/pi/sysdata/DHT22`
i_temp=`echo $TH_STAR | awk '{print $1}'`
i_hum=`echo $TH_STAR | awk '{print $2}'`

STR=`awk 'BEGIN{printf "{\"datastreams\":[ {\"id\":\"load\",\"current_value\":\"%.2f\"}, {\"id\":\"temp\",\"current_value\":\"%.2f\"},{\"id\":\"i_temp\",\"current_value\":\"%.2f\"},{\"id\":\"i_hum\",\"current_value\":\"%.2f\"}] } ",'$cpu_load','$cpu_t','$i_temp','$i_hum'}'`

echo ${STR}
echo ${STR} > ${LOCATION}/cosm.json

curl -s -v --request PUT --header "X-ApiKey: ${API_KEY}" --data-binary @${LOCATION}/cosm.json ${COSM_URL}

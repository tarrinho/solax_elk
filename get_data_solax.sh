#!/bin/bash

IP=192.168.1.1

date=`date --iso-8601=seconds`
solax_event=`curl http://$IP/api/realTimeData.htm -s`
solax_event_without_end_brackets="${solax_event%?}"
solax_event_final="$solax_event_without_end_brackets,\"Date\":\"$date\"}"

#for logging purpose
echo "$solax_event_final" >> /var/log/solax/solax_events.`date -I`.log

#!/bin/bash
LOG_PATH='/home/pi/Logs/reconnect.log'
now=$(date +"d-%m %r")
while true
do
pingip='google.com'
/bin/ping -c 2 -I wlan0 $pingip > /dev/null
if [ $? -eq 0 ] 
then
  true
  #echo "Network OK"
else
  echo "$now Network down, fixing..." >> $LOG_PATH
  /sbin/ifdown wlan0
  sleep 5
  /sbin/ifup --force wlan0
  echo "wlan0 reconnected at `date`"
fi
sleep 60
done
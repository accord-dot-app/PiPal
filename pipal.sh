#!/bin/bash

sh setup.sh

DIR_NAME=$(dirname "$0")

CPU=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}')
MEMORY=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
STORAGE=$(df -h --total | grep total | awk '{print $5}' | sed -e 's/[%]//g')

LONG_TEMP=$(cat /sys/class/thermal/thermal_zone*/temp)
TEMP=$(expr $LONG_TEMP / 1000)

DATE_TIME=$(date +"%D %T")
LOG_PATH="$DIR_NAME/log.csv"

if [ ! -s $LOG_PATH ]; then
  echo time,cpu,memory,storage,temp > $LOG_PATH
fi

echo $DATE_TIME,$CPU,$MEMORY,$STORAGE,$TEMP >> $LOG_PATH
#!/bin/bash

IPMIHOST=`cat /host.txt`
IPMIUSER=`cat /user.txt`
IPMIPW=`cat /pw.txt`
DECIMAL_FAN_SPEED=`cat /decimal_fan_speed.txt`
HEXADECIMAL_FAN_SPEED=`cat /hexadecimal_fan_speed.txt`
MAXTEMP=32


if [[ $IPMIHOST == "local" ]]
then
  LOGIN_STRING='open'
else
  LOGIN_STRING="lanplus -H $IPMIHOST -U $IPMIUSER -P $IPMIPW"
fi

TEMP=$(ipmitool -I $LOGIN_STRING sdr type temperature |grep Inlet |grep degrees |grep -Po '\d{2}' | tail -1)

echo "Current Temp is $TEMP C"
if [ $TEMP -gt $MAXTEMP ];
then
  echo "Temp is too high. Activating dynamic fan control"
  ipmitool -I $LOGIN_STRING raw 0x30 0x30 0x01 0x01
else
  echo "Temp is OK. Using manual fan control"
  ipmitool -I $LOGIN_STRING raw 0x30 0x30 0x01 0x00
  ipmitool -I $LOGIN_STRING raw 0x30 0x30 0x02 0xff $HEXADECIMAL_FAN_SPEED
fi

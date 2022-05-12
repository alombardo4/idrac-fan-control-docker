#!/bin/bash

echo $IDRAC_HOST >> /host.txt
echo $IDRAC_USER >> /user.txt
echo $IDRAC_PW >> /pw.txt
echo ${MAXTEMP:-32} >> /maxtemp.txt

if [[ $FAN_SPEED == 0x* ]]
then
  DECIMAL_FAN_SPEED=$(printf '%d' $FAN_SPEED)
  HEXADECIMAL_FAN_SPEED=$FAN_SPEED
else
  DECIMAL_FAN_SPEED=$FAN_SPEED
  HEXADECIMAL_FAN_SPEED=$(printf '0x%02x' $FAN_SPEED)
fi

echo $DECIMAL_FAN_SPEED >> /decimal_fan_speed.txt
echo $HEXADECIMAL_FAN_SPEED >> /hexadecimal_fan_speed.txt

echo "Host: `cat /host.txt`"
if [[ $IDRAC_HOST != "local" ]]
then
  echo "User: `cat /user.txt`"
  echo "PW: `cat /pw.txt`"
fi
echo "Fan speed objective: `cat /decimal_fan_speed.txt`%"
echo "Max temp: `cat /maxtemp.txt`"

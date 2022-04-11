#!/bin/bash

echo $IDRAC_HOST >> /idrac_host.txt
echo $IDRAC_USERNAME >> /idrac_username.txt
echo $IDRAC_PASSWORD >> /idrac_password.txt

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

echo "Idrac/IPMI host: `cat /idrac_host.txt`"
if [[ $IDRAC_HOST != "local" ]]
then
  echo "Idrac/IPMI user: `cat /idrac_username.txt`"
  echo "Idrac/IPMI password: `cat /idrac_password.txt`"
fi
echo "Fan speed objective: `cat /decimal_fan_speed.txt`%"

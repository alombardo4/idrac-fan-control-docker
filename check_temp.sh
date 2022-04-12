#!/bin/bash

IPMI_HOST=`cat /idrac_host.txt`
IPMI_USERNAME=`cat /idrac_username.txt`
IPMI_PASSWORD=`cat /idrac_password.txt`
DECIMAL_FAN_SPEED=`cat /decimal_fan_speed.txt`
HEXADECIMAL_FAN_SPEED=`cat /hexadecimal_fan_speed.txt`
MAXIMUM_INLET_TEMPERATURE=`cat /maximum_inlet_temperature.txt`

if [[ $IPMI_HOST == "local" ]]
then
  LOGIN_STRING='open'
else
  LOGIN_STRING="lanplus -H $IPMI_HOST -U $IPMI_USERNAME -P $IPMI_PASSWORD"
fi

INLET_TEMPERATURE=$(ipmitool -I $LOGIN_STRING sdr type temperature |grep Inlet |grep degrees |grep -Po '\d{2}' | tail -1)

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "------------------------------------"
echo "Current inlet temperature is $INLET_TEMPERATURE °C."
if [ $INLET_TEMPERATURE -gt $MAXIMUM_INLET_TEMPERATURE ]
then
  printf "Inlet temperature is ${RED}too high${NC}. Activating default dynamic fan control."
  ipmitool -I $LOGIN_STRING raw 0x30 0x30 0x01 0x01
else
  printf "Inlet temperature is ${GREEN}OK${NC}. Using manual fan control with ${DECIMAL_FAN_SPEED}%% fan speed."
  ipmitool -I $LOGIN_STRING raw 0x30 0x30 0x01 0x00
  ipmitool -I $LOGIN_STRING raw 0x30 0x30 0x02 0xff $HEXADECIMAL_FAN_SPEED
fi

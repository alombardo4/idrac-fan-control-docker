IPMIHOST=`cat /host.txt`
IPMIUSER=`cat /user.txt`
IPMIPW=`cat /pw.txt`
FANSPEED=`cat /fanspeed.txt`

MAXTEMP=${MAXTEMP:-32}

TEMP=$(ipmitool -I lanplus -H $IPMIHOST -U $IPMIUSER -P $IPMIPW sdr type temperature |grep Inlet |grep degrees |grep -Po '\d{2}' | tail -1)

echo "Current Temp is $TEMP C"
if [ $TEMP -gt $MAXTEMP ];
then
  echo "Temp is too high. Activating dynamic fan control"
  ipmitool -I lanplus -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x01 0x01
else
  echo "Temp is OK. Using manual fan control"
  ipmitool -I lanplus -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x01 0x00
  ipmitool -I lanplus -H $IPMIHOST -U $IPMIUSER -P $IPMIPW raw 0x30 0x30 0x02 0xff $FANSPEED
fi

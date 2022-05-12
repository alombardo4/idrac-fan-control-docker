echo $IDRAC_HOST >> /host.txt
echo $IDRAC_USER >> /user.txt
echo $IDRAC_PW >> /pw.txt
echo $FANSPEED >> /fanspeed.txt
echo ${MAXTEMP:-32} >> /maxtemp.txt

echo "Host: `cat /host.txt`"
echo "User: `cat /user.txt`"
echo "PW: `cat /pw.txt`"
echo "Fan speed `cat /fanspeed.txt`"
echo "Max temp: `cat /maxtemp.txt`"

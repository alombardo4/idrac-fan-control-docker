#!/bin/bash

echo $IDRAC_HOST >> /host.txt
echo $IDRAC_USER >> /user.txt
echo $IDRAC_PW >> /pw.txt
echo $FANSPEED >> /fanspeed.txt

echo "Host: `cat /host.txt`"
if [[ $IDRAC_HOST != "local" ]]
then
  echo "User: `cat /user.txt`"
  echo "PW: `cat /pw.txt`"
fi
echo "Fan speed `cat /fanspeed.txt`"

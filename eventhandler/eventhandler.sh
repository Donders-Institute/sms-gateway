#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'No arguments given...exiting'
    exit 1
fi

status=`echo $1`
smsfile=`echo $2`

if [[ $status = "RECEIVED" ]]
then
 /root/UPSGUARD_V1/receive/readsms.sh $smsfile
fi

if [[ $status = "FAILED" ]]
then
 echo "!!!SENDING SMS FAILED!!! $2"
fi

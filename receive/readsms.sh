#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'No arguments given...exiting'
    exit 1
fi

#some variables being set
DATE=$(date +"%d-%m-%Y %H:%M")
DATELONG=$(date +"%Y%m%d-%H%M")
fromtg=false

#echo SMS reading script started.
 from=`cat "$1" | grep From: | sed -r 's/^From: //'`
 body=`cat "$1" | tail --lines=+14`
 user=`cat "/root/UPSGUARD_V1/recipients/tg.txt" | grep $from | awk  '{print $2}'`
 mail=`cat "/root/UPSGUARD_V1/recipients/tg.txt" | grep $from | awk  '{print $3}'`

#check if SMS is from TG recipients list
if [[ `cat "/root/UPSGUARD_V1/recipients/tg.txt" | grep $from`  ]]
then
 fromtg=true
fi


#check if "Status" or "status" is received

if [[ "$fromtg" = true  ]]
then
 if [[ $body = "status" || $body = "Status" && ! -f status.txt ]]
 then
  echo "$mail" > status.txt
  sendsms "s4000" "STATUS"
  rm -f "$1"
  exit 0
 fi
fi


#relay SMS from vodafone to mail if status.txt exists (E-mail of user is in text file)
if [[ $from = "Vodafone" && -f status.txt ]]
then
 usermail=`cat status.txt`
 echo "$body" | mail -s "Vodafone Status Received" "$usermail"
 echo "Received sms from Vodafone, relaying to user"
 rm status.txt
 rm -f "$1"
 exit 0
fi

#main check of sms messages.

if [[ "$fromtg" = true  ]]
then
  echo "SMS received from $user: $body"
  echo "Sending Reply to TG members"

 while IFS=" " read -r smsnumber smsuser; do
     if [ ! ${smsnumber:0:1} == "#" ]
     then
      sendsms "$smsnumber" "$user responded: \"$body\""
     fi
 done < /root/UPSGUARD_V1/recipients/tg.txt

  echo "removing received sms"
  rm -f "$1"
else
 echo "Phone number of received sms not in recipients list, ignoring and sending via e-mail to helpdesk..."
 cat $1 | mail -s "$DATE: Received SMS from non-tg member:" "helpdesk@fcdonders.ru.nl"
 rm -f "$1"
fi

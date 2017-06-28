#!/bin/bash

#Check if UPS snmp is available at all

snmpget -v 1 -Oqv -c public 131.174.44.221 .1.3.6.1.4.1.318.1.1.1.11.1.1.0 > /dev/null 2>&1
if [[ $? != 0 ]]
then
echo "SNMP UNAVAILABLE! Exiting..."
echo "Warning: smsserver.dccn.nl has detected a problem with getting SNMP values from UPS.dccn.nl, please check the connection of the UPS and/or SMSServer" | mail -s "WARNING: SNMP connection error to ups.dccn.nl" "helpdesk@fcdonders.ru.nl"
exit 1
else
#echo "SNMP Available, continuing"
:
fi

#Beginning of main SMS script

DATE=$(date +"%d-%m-%Y %H:%M:%S")
IFS=', ' read -r -a codes <<< `snmpget -v 1 -Oqv -c public 131.174.44.221 .1.3.6.1.4.1.318.1.1.1.11.1.1.0 | sed "s/\"//g" | sed 's/\(.\)/\1,/g'`
timerdir="/root/UPSGUARD_V1/send/timers"

#echo "$DATE"

if [[ ${codes[1]} -eq "0" ]]; then
 rm $timerdir/onbat.timer 2>/dev/null
 if [[ $? -eq "0" ]]; then
  echo "removing onbat timer file, incident over"
 fi
 else
 echo "Critical: UPS running on Battery Power!"
 onbat="-o"
fi

if [[ ${codes[2]} -eq "0" ]]; then
 rm $timerdir/lowbat.timer 2>/dev/null
 if [[ $? -eq "0" ]]; then
  echo "removing lowbat timer file, incident over"
 fi
else
 echo "Critical: UPS Battery LOW!"
 lowbat="-l"
fi

if [[ ${codes[39]} -eq "0" ]]; then
 rm $timerdir/critbat.timer 2>/dev/null
 if [[ $? -eq "0" ]]; then
  echo "removing critbat timer file, incident over"
 fi
else
 echo "Critical: UPS shutdown imminent due to low battery"
 critbat="-c"
fi

if [[ -z $onbat && -z $lowbat && -z $lowbatshut ]]; then
 #echo "Nothing to do, going to sleep"
 :
else
 /root/UPSGUARD_V1/send/smstg.sh $onbat $lowbat $critbat
fi

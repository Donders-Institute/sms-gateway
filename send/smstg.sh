#!/bin/bash

#Creating 2 date variabled for the message
DATE=$(date +"%d-%m-%Y %H:%M")
timerdir="/root/UPSGUARD_V1/send/timers"

#Setting default state of error variables
onbat=0
lowbat=0
critbat=0

# As long as there is at least one more argument, keep looping
while [[ $# -gt 0 ]]; do
    arguments="$1"
    case "$arguments" in
        # On battery argument, Will catch either -o or --onbat
        -o|--onbat)
	if [ ! -e "$timerdir/onbat.timer" ] ; then onbat=1 ; fi
        ;;
        # Low battery argument, Will catch either -l or --lowbat
        -l|--lowbat)
        if [ ! -e "$timerdir/lowbat.timer" ] ; then lowbat=1 ; fi
        ;;
        # Critical battery argument, Will catch either -c or --critbat
        -c|--critbat)
        if [ ! -e "$timerdir/critbat.timer" ] ; then critbat=1 ; fi
        ;;
        *)
        #if no valid argument is given.
        echo "Unknown option '$arguments'"
	exit
        ;;
    esac
    # Shift after checking all the cases to get the next option
    shift
done

#check if arguments given are #
if [ $onbat -eq "1" ]; then
   if [ ! -f $timerdir/onbat.timer ]; then
   touch $timerdir/onbat.timer
   echo "touching onbat.timer file because non existant"
   fi
   echo "sending sms for onbat"
    while IFS=" " read -r onbatnumber onbatname; do
     if [ ! ${onbatnumber:0:1} == "#" ]
     then
      sendsms "$onbatnumber" "$DATE - $onbatname, Critical: UPS is on battery power! (mains failure)"
     fi
    done < "/root/UPSGUARD_V1/recipients/tg.txt"
fi


if [ $lowbat -eq "1" ]; then
   if [ ! -f $timerdir/lowbat.timer ]; then
   touch $timerdir/lowbat.timer
   echo "touching lowbat.timer file because non existant"
   fi
   echo "sending sms for lowbat"
    while IFS=" " read -r lowbatnumber lowbatname; do
     if [ ! ${lowbatnumber:0:1} == "#" ]
     then
      sendsms "$lowbatnumber" "$DATE - $lowbatname, Critical: UPS is low on battery!"
     fi
    done < "/root/UPSGUARD_V1/recipients/tg.txt"
fi


if [ $critbat -eq "1" ]; then
   if [ ! -f $timerdir/critbat.timer ]; then
   touch $timerdir/critbat.timer
   echo "touching critbat.timer file because non existant"
   fi
   echo "sending sms for critbat"
    while IFS=" " read -r critbatnumber critbatname; do
     if [ ! ${critbatnumber:0:1} == "#" ]
     then
      sendsms "$critbatnumber" "$DATE - $critbatname, Critical: UPS batterys critical! Shutdown Imminent."
     fi
    done < "/root/UPSGUARD_V1/recipients/tg.txt"
fi

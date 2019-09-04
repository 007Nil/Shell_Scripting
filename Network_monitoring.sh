#!/bin/bash
################################################
#Auther = Sagnik Sarkar
#Use Case: Monitoring Network avalability
#Date: Wednesday 04.09.2018
################################################
#Script Starts HERE!!!

COUNT=30
HASNET=0
NONET=0

# email report when 
SUBJECT="Ping failed"
SUBJECT2="40% Ping Failed"
EMAILID="Your mail address"
SUBJECT3="100% Ping Avalable"
while [ 1 ]
do
  count=$(ping -c $COUNT 8.8.8.8  | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
  if [ "$count" = "0" ];  then
    # 100% failed 
    if [ "$NONET" = "0" ]; then
    echo "Host : All Servers are down (ping failed) at $(date)" | mail -s "$SUBJECT" $EMAILID
    echo "Mail is send to inform there is no internet"
    HASNET=1
    NONET=1
    fi
  fi
  if [ "$count" = "20" ];then
    #40% failed
    echo "Host : All Servers are Critical (40% ping failed) at $(date)" | mail -s "$SUBJECT2" $EMAILID
    HASNET=1
    fi
    if [ "$count" = "30" ];then
      if [ "$HASNET" = "1" ];then
         echo "Host : All Servers are running properly (100% ping) at $(date)" | mail -s "$SUBJECT3" $EMAILID
         HASNET=0
#   echo "HI"
         NONET=0
      fi 
    fi
#Generated Logs in logfile
        if [ "$count" = "30" ];then
                echo " Network is completly Stable at $(date) and All Servers are Up and Running "
        else
                echo "Network is down at $(date)"
        fi
    echo " $HASNET is value for HASNET variable for debug purpused "
    echo "$NONET   is value for NONET variable for debug purpused"
done




#!/bin/bash
################################################
#Auther = Sagnik Sarkar
#Use Case: Monitoring Network avalability
#Date: Wednesday 04.09.2019
#Modification : 26.09.2019
################################################
#Script Starts HERE!!!

COUNT=100
HASNET=0
NONET=0

# email report when 
SUBJECT="Ping failed"
SUBJECT2="40% Ping Failed"
EMAILIDS="example@email.com"
SUBJECT3="Network Monitor Result"
while [ 1 ]
do
  count=$(ping -c $COUNT 8.8.8.8  | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
  if [ "$count" = "0" ];  then
    # 100% failed 
    if [ "$NONET" = "0" ]; then
    NETGONEDATE=$(date)
    NETGONETIME=$(date +%s)
#   echo "Host : All Servers are down (ping failed) at $(date)" | mail -s "$SUBJECT" $EMAILIDS
#   echo "Host : All Servers are down (ping failed) at $(date)"
    HASNET=1
    NONET=1
    fi
  fi
  if [ "$count" -lt "60" ];then
     if [ "NONET" = "0" ];then
    #40% failed
    NETGONEDATE=$(date)
    NETGONETIME=$(date +%s)
#   echo "Host : All Servers are Critical (40% ping failed) at $(date)" | mail -s "$SUBJECT2" $EMAILIDS
#   echo "Host : All Servers are Critical (40% ping failed) at $(date)"
    HASNET=1
    NONET=1
     fi
    fi
    if [ "$count" = "100" ];then
      if [ "$HASNET" = "1" ];then
         TOTALTIME=$(date -ud "@$(($(date +%s) - $NETGONETIME))" +%T)
         echo "Host: All Servers are down (ping failed) at $NETGONEDATE and Back Online at $(date). Servers are offline for $TOTALTIME (HH:MM:SS)" | mail -s "$SUBJECT3" $EMAILIDS
#        echo "Host : All Servers are running properly (100% ping) at $(date)"
         HASNET=0
#   echo "HI"
         NONET=0
      fi 
    fi
#Generated Logs in logfile
#        if [ "$count" = "100" ];then
#                echo " Network is completly Stable at $(date) and All Servers are Up and Running "
#       elif [ "$count" -lt 60  ];then
#               echo "Network is Critical (40% ping failed)  at $(date)"
#       else
#                echo "Network is Down (100% Ping Failed)  at $(date)"
#        fi
#    echo " $HASNET is value for HASNET variable for debug purpused "
#    echo " $NONET is value for NONET variable for debug purpused"
done



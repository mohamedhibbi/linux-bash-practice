#!/bin/bash
# Script that monitors the top active process. the script send an email to the user root if 
# utilization of the top active process goes beyond 80% 

while true 
do
       #check every 6 seconds if we have a process causing high CPU  load 
       sleep 6 
       PINFO=$(ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1)
       USAGE=$(echo $PINFO | awk '{ print $1}')
       USAGE=${USAGE%.*} 
       PID=$(echo $PINFO | awk '{ print $2 }') 
       PNAME=$(echo $PINFO | awk '{ print $3 }') 
      
       # only if we have a high CPU load one process, run a check within 7 seconds 
       # In this check, we should monitor if the process is still that active 
       # if that's the case, root gets a message 
       
       if [ $USAGE -gt 80 ]
       then
	      USAGE1=$USAGE
	      PID1=$PID
	      PNAME1=$PNAME
	      sleep 7
	      
	      PINFO2=$(ps -eo pcpu,pid -o comm= | sort -k1 -n -r | head -1)
	      USAGE2=$(echo $PINFO2 | awk '{ print $1 }')
	      USAGE2=${USAGE2%.*}  
	      PID2=$(echo $PINFO2 | awk '{ print $2 }')
	      PNAME2=$(echo $PINFO2 | awk '{ print $3 }')
       fi

       [ $USAGE -gt 80 ] && [ $PID1 = $PID2 ] && logger HIGH CPU UTILIZATION ON $PNAME
done


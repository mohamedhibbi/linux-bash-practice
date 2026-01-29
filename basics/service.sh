#!/bin/bash
# $1 is the first argument passed to the script 
ACTION="$1"
#check if the user provided an action 
if [[ -z "$ACTION" ]]; then 
	echo "Error: No Action Provided" 
	echo "Usage: $0 [start|stop|restart]"
	exit 1
fi 

case "$ACTION" in 
	start)
		echo "Starting the Service..."
		# Place Your systemctl start command here
		;;
	stop)
		echo "Stopping the Service..."
		# place Your systemctl stop command here 
		;;
	restart)
		echo "Restarting the Service..."
		# Place your systemctl restart command here 
		;;
	*)
		echo "Error: Unknown action '$ACTION'."
		echo "Usage: $0 [start|stop|restart]"
		exit 1
		;;
esac 

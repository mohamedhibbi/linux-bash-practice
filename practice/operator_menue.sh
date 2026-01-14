#!/bin/bash 
# Let's Write a Menue that offers  the Following requirements available disk space, available ram and users currently logged in 
# and should not be possible to exit from the menue using CTRL-C 

PS3='Enter your choice: ' 
options=("See Disk Space" "Check Memory" "List current users" "Quit")

trap "ignoring ctrl-c" SIGINT

select opt in "${options[@]}" 
do
	case $opt in 
		"See Disk Space")
			df -h 
			;;
		"Check Memory")
			free -h 
			;;
		"List current users")
			who
			;;
		"Quit")
			break
			;;
		*)
			echo "invalid option $REPLY" 
			;;
	esac	
done

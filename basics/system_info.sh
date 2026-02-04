#!/bin/bash 
# now we want to display the hostname 
echo "the Hostname is:" $(hostname)

# now we want to display the system information 
echo "System Information:"
hostnamectl 

# now we want to see who logged in 
echo "Users Logged in Are:" 
who

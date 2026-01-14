#!/bin/bash
# makeusr - create a Linux user with optional UID, GID, home directory, shell, and info
# Usage: makeusr [-u uid] [-g gid] [-i info] [-h homedir] [-s shell] username

# Function to display usage and exit
usage(){ 
    echo 'usage: makeusr [-u uid] [-g gid] [-i info] [-h homedir]' 
    echo '[-s shell] username' 
    exit 1 
} 

# Function to display help message describing the script
helpmessage(){ 
    echo "makeusr is a script to create a Linux user with optional parameters."
    echo "You can specify UID, GID, user info, home directory, and login shell."
    echo "This script checks for existing UIDs and assigns a free UID if none is provided."
} 

# -----------------------------
# Parse command-line options
# -----------------------------
while getopts "u:g:i:h:s:" opt; do 
    case $opt in 
        u ) uid=$OPTARG ;;         # Optional UID
        g ) gid=$OPTARG ;;         # Optional GID
        i ) info=$OPTARG ;;        # Optional user info/comment
        h ) home=$OPTARG ;;        # Optional home directory
        s ) shell=$OPTARG ;;       # Optional login shell
        ? ) helpmessage ;;         # Unknown option triggers help
        * ) usage ;;               # Fallback to usage for safety
    esac 

    # Shift positional parameters after processing options
    # (removes processed options from $1, $2, ...)
    shift $(($OPTIND -1)) 
done 

# -----------------------------
# Validate username argument
# -----------------------------
if [ -z "$1" ]; then 
    usage                       # Username is required
fi 

if [ -n "$2" ]; then 
    usage                       # Only one positional argument allowed
fi 

# -----------------------------
# Assign default UID if not provided
# -----------------------------
if [ -z "$uid" ]; then 
    uid=500
    # Loop to find first free UID starting from 500
    while cut -d : -f3 /etc/passwd | grep -x $uid
    do 
        uid=$(( uid + 1 )) > /dev/null 
    done 
fi

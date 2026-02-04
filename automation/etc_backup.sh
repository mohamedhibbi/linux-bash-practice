#!/bin/bash

DIR=/root/backup
FILE=/etc/cron.d/etc_backup
# Lets' make sure this sqcript is running as ROOT
if [[ $EUID -ne 0 ]];then 
	echo "This Script should Run AS Root..."
	exit 1 
fi


# Check backup directory
if ! [[ -d "$DIR" ]]; then
    read -p "Directory $DIR does not exist. Create it? (yes/no): " answer
    case "$answer" in
        y|Y|yes|YES) mkdir -p "$DIR"; echo "Directory created";;
        n|N|no|NO) echo "Directory not created"; exit 3;;
        *) echo "Invalid input"; exit 4;;
    esac
fi

# Backup /etc
tar -cjvf "$DIR/etc_backup.bz2" /etc
sync
echo "Backup completed at $DIR/etc_backup.bz2"

# Cron job creation
if [[ -f "$FILE" ]]; then
    echo "Cron file $FILE already exists, skipping creation..."
else
    echo "Creating cron job at $FILE..."
    cat > "$FILE" << EOF
# Run the script every night at 11:00 PM except Sundays
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
0 23 * * MON-SAT root bash /root/$(basename "$0")
EOF
    chmod 644 "$FILE"
    echo "Cron job created at $FILE"
fi


#!/bin/bash

# -------------------------------
# Purpose: /etc Backup Script
# Author: Mohamed Hibbi
# -------------------------------

# 1️⃣ Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "The script $0 should run as root"
    exit 1
fi

# 2️⃣ Backup directory
DIR=/root/backup

if ! [[ -d "$DIR" ]]; then
    echo "The directory $DIR does not exist."
    read -p "Do you want to create it? (yes/no): " answer
    case "$answer" in
        y|Y|yes|YES)
            mkdir -p "$DIR"
            echo "The directory $DIR has been created..."
            ;;
        n|N|no|NO)
            echo "The directory $DIR will not be created. Exiting."
            exit 3
            ;;
        *)
            echo "Unknown option, please insert yes/no"
            exit 4
            ;;
    esac
else
    echo "The directory $DIR is ready to use..."
fi

# 3️⃣ Backup /etc using bzip2
BACKUP_FILE="$DIR/etc_backup.bz2"
tar -cjvf "$BACKUP_FILE" /etc
sync
echo "Backup completed successfully at $BACKUP_FILE"

# 4️⃣ Cron job creation
CRON_FILE=/etc/cron.d/etc_backup

if [[ -f "$CRON_FILE" ]]; then
    echo "Cron file $CRON_FILE already exists, skipping creation..."
else
    echo "Creating cron job at $CRON_FILE..."
    cat > "$CRON_FILE" << EOF
# Run the script every night at 11:00 PM except Sundays
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
0 23 * * MON-SAT root bash /root/$(basename "$0")
EOF
    chmod 644 "$CRON_FILE"
    echo "Cron job created at $CRON_FILE"
fi


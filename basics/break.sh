#!/bin/bash

# =====================================================
# Script : Find the first corrupted log file
# Purpose: Demonstrate how the "break" statement works
# Author : Mohamed Hibbi
# =====================================================

LOG_DIR="/var/log/my-app"
FOUND_FILE=""

# Loop through all .log files in the directory
for log_file in "$LOG_DIR"/*.log; do
    echo "🔍 Scanning file: $log_file"

    # Search for the word "error" (case-insensitive)
    # -q : quiet mode (no output, only exit status)
    # -i : ignore case
    if grep -qi "error" "$log_file"; then
        echo "❌ Error found in: $log_file"

        # Save the first corrupted file
        FOUND_FILE="$log_file"

        # 🚨 break stops the loop immediately
        # No more files will be scanned after this point
        break
    fi
done

# Code execution continues here AFTER the break
if [[ -n "$FOUND_FILE" ]]; then
    echo "✅ First corrupted file: $FOUND_FILE"
    exit 1
else
    echo "🎉 No corrupted files found."
    exit 0
fi


#!/bin/bash
# ------------------------------------------------------------
# Script: pattern-matching.sh
# Purpose: Demonstrate Bash parameter expansion for extracting
#          date fields (day, month, year)
# Author: Mohamed Hibbi
# ------------------------------------------------------------

# Get current date in format: DD-MM-YY
DATE=$(date +%d-%m-%y)
echo "Full date: $DATE"

# Extract day (remove longest match from first dash onward)
TODAY=${DATE%%-*}

# Remove only last dash section to isolate month
TEST=${DATE%-*}
THISMONTH=${TEST##*-}

# Extract year (remove everything up to last dash)
THISYEAR=${DATE##*-}

# Output results
echo "Today is: $TODAY"
echo "This month is: $THISMONTH"
echo "This year is: $THISYEAR" 


# Bash Pattern Reminder:
# %  -> delete from the RIGHT side (end of string)
# #  -> delete from the LEFT side (start of string)
# Double %% or ## removes the LONGEST match
# Single % or # removes the SHORTEST match 

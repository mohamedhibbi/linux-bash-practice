#!/bin/bash
# Display current day, month, year

DATE=$(date +%d-%m-%y)
echo $DATE   # 17-01-26

TODAY=${DATE%%-*}
TEST=${DATE%-*}  # 17-01
THISMONTH=${TEST##*-}
THISYEAR=${DATE##*-}       

echo today is $TODAY
echo this month is $THISMONTH
echo this year is  $THISYEAR 

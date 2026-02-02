#!/bin/bash
LOG_DIR=/var/log/my-app
FOUND_FILE=""

# Loop through all files ending with .log 
for log_file in "$LOG_DIR"/*.log; do 

	echo "Scanning file: $log_file"
# -q (quiet) option makes grep silent; we only care about the exit code 
  if grep -qi "error" "$log_file"; then 
	echo "found error in $log_file"
	FOUND_FILE="$log_file"

# Now we want to stop scanning because we find the first corrupted file 
        break
  fi
done

# the script continues here the break 

  if [[ -n "$FOUND_FILE" ]]; then
# -n options is for  STRING True if string is not empty. 
	  echo "the first corrupted file is: $FOUND_FILE"
  else 
	  echo "No corrupted files found." 
  fi 

	

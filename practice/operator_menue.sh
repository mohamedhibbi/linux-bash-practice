#!/bin/bash
# Interactive Bash menu to display basic system information
# Demonstrates: select, PS3, trap (SIGINT), and case statements

PS3='Enter your choice: '

options=(
  "See Disk Space"
  "Check Memory"
  "List current users"
  "Quit"
)

# Prevent exiting the menu using CTRL-C
trap "echo 'CTRL-C is disabled in this menu'" SIGINT

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
            echo "Invalid option: $REPLY"
            ;;
    esac
done


#!/bin/bash
################################################################################
# Script Name: service.sh
# Author: Mohamed Hibbi
# Usage: ./service.sh [start|stop|restart|status] <service>
# Example: ./service.sh restart sshd
################################################################################
# First argument is the action (start/stop/restart/status)
ACTION="$1"
# Second argument is the service name
SERVICE="$2"

# Check if both arguments are provided
if [[ -z "$ACTION" || -z "$SERVICE" ]]; then
    echo "Usage: $0 [start|stop|restart|status] <service>"
    exit 1
fi

# Require root privileges to run systemctl
if [[ $EUID -ne 0 ]]; then
    echo "Please run as root."
    exit 1
fi

# Main case statement to handle actions
case "$ACTION" in
    start)
        echo "Starting $SERVICE..."
        systemctl start "$SERVICE" && echo "Service started successfully."
        ;;
    stop)
        echo "Stopping $SERVICE..."
        systemctl stop "$SERVICE" && echo "Service stopped successfully."
        ;;
    restart)
        echo "Restarting $SERVICE..."
        systemctl restart "$SERVICE" && echo "Service restarted successfully."
        ;;
    status)
        echo "Status of $SERVICE:"
        systemctl status "$SERVICE"
        ;;
    *)
        echo "Unknown action: $ACTION"
        echo "Usage: $0 [start|stop|restart|status] <service>"
        exit 1
        ;;
esac


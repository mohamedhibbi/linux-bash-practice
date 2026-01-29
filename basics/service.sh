#!/bin/bash

ACTION="$1"
SERVICE="$2"

if [[ -z "$ACTION" || -z "$SERVICE" ]]; then
    echo "Usage: $0 [start|stop|restart|status] <service>"
    exit 1
fi

# Require root
if [[ $EUID -ne 0 ]]; then
    echo "Please run as root."
    exit 1
fi

case "$ACTION" in
    start)
        echo "Starting $SERVICE..."
        systemctl start "$SERVICE"
        ;;
    stop)
        echo "Stopping $SERVICE..."
        systemctl stop "$SERVICE"
        ;;
    restart)
        echo "Restarting $SERVICE..."
        systemctl restart "$SERVICE"
        ;;
    status)
        systemctl status "$SERVICE"
        ;;
    *)
        echo "Unknown action: $ACTION"
        echo "Usage: $0 [start|stop|restart|status] <service>"
        exit 1
        ;;
esac

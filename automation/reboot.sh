cat > /usr/local/reboot.sh << REBOOT
#!/bin/bash
echo "Reboot job executed at \$(date)" >> /tmp/after-reboot
logger "One-time reboot service executed"
/bin/systemctl disable reboot.service
exit 0
REBOOT

chmod +x /usr/local/reboot.sh

cat > /etc/systemd/system/reboot.service << SERVICE
[Unit]
Description=One-Time Reboot Automation Script
After=network.target

[Install]
WantedBy=multi-user.target

[Service]
Type=simple
ExecStart=/usr/local/reboot.sh
SERVICE

systemctl daemon-reload
systemctl enable reboot.service
reboot


cat > /usr/local/reboot.sh << REBOOT
#!/bin/bash 
echo DONE > /tmp/after-reboot
systemctl disable reboot.service
REBOOT

chmod +x /usr/local/reboot.sh

cat > /etc/systemd/system/reboot.service << SERVICE
[Unit]
Description=REBOOT

[Install]
WantedBy=multi-user.target 

[Service]
Type=simple
WorkingDirectory=/usr/local
ExecStart=/usr/local/reboot.sh
SERVICE

systemctl daemon-reload
systemctl enable reboot.service

reboot

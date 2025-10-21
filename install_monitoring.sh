#!/bin/bash
# Script: install_monitoring.sh
set -e

echo "Installing Test Process Monitoring..."

[ "$EUID" -ne 0 ] && { echo "Run as root"; exit 1; }

mkdir -p /usr/local/bin /etc/systemd/system
cp monitor_test.sh /usr/local/bin/
chmod +x /usr/local/bin/monitor_test.sh
cp monitoring-test.service monitoring-test.timer /etc/systemd/system/
touch /var/log/monitoring.log
chmod 644 /var/log/monitoring.log

systemctl daemon-reload
systemctl enable --now monitoring-test.timer

echo "Installation completed successfully!"
systemctl status monitoring-test.timer --no-pager
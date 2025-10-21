#!/bin/bash
# Script: uninstall_monitoring.sh
set -e

echo "Uninstalling Test Process Monitoring..."

[ "$EUID" -ne 0 ] && { echo "Run as root"; exit 1; }

systemctl stop monitoring-test.timer 2>/dev/null || true
systemctl disable monitoring-test.timer 2>/dev/null || true
rm -f /etc/systemd/system/monitoring-test.service
rm -f /etc/systemd/system/monitoring-test.timer
rm -f /usr/local/bin/monitor_test.sh
rm -f /var/run/monitoring_test.pid

systemctl daemon-reload

echo "Uninstallation completed successfully!"
#!/bin/bash

set -e

echo "Installing Test Process Monitoring..."

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Create necessary directories
mkdir -p /usr/local/bin
mkdir -p /etc/systemd/system

# Copy monitoring script
echo "Installing monitoring script..."
cp scripts/monitor_test.sh /usr/local/bin/
chmod +x /usr/local/bin/monitor_test.sh

# Copy systemd service and timer files
echo "Installing systemd service and timer..."
cp systemd/monitoring-test.service /etc/systemd/system/
cp systemd/monitoring-test.timer /etc/systemd/system/

# Create log file
touch /var/log/monitoring.log
chmod 644 /var/log/monitoring.log

# Reload systemd to recognize new units
echo "Reloading systemd daemon..."
systemctl daemon-reload

# Enable and start timer
echo "Enabling and starting monitoring timer..."
systemctl enable --now monitoring-test.timer

echo "Installation completed successfully!"
echo "Timer status:"
systemctl status monitoring-test.timer --no-pager
#!/bin/bash

# Script: /usr/local/bin/monitor_test.sh
# Description: Monitor test process and report to monitoring server

LOG_FILE="/var/log/monitoring.log"
MONITORING_URL="https://test.com/monitoring/test/api"
PROCESS_NAME="test"
PID_FILE="/var/run/monitoring_test.pid"

# Function to log messages with timestamp
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Get current PID of the process
get_process_pid() {
    pgrep -x "$PROCESS_NAME"
}

# Call monitoring API
call_monitoring_api() {
    local response_code
    response_code=$(curl -s -o /dev/null -w "%{http_code}" -H "Content-Type: application/json" \
        -d "{\"process\": \"$PROCESS_NAME\", \"status\": \"running\", \"timestamp\": \"$(date -Iseconds)\"}" \
        "$MONITORING_URL")

    if [ "$response_code" -ne 200 ]; then
        log_message "ERROR: Monitoring server returned HTTP $response_code"
        return 1
    fi
    return 0
}

# Main monitoring logic
main() {
    touch "$LOG_FILE"

    CURRENT_PID=$(get_process_pid)

    if [ -n "$CURRENT_PID" ]; then
        # Check if process was restarted
        if [ -f "$PID_FILE" ]; then
            PREVIOUS_PID=$(cat "$PID_FILE")
            if [ "$CURRENT_PID" != "$PREVIOUS_PID" ]; then
                log_message "INFO: Process $PROCESS_NAME restarted. Previous PID: $PREVIOUS_PID, Current PID: $CURRENT_PID"
            fi
        fi

        # Save current PID
        echo "$CURRENT_PID" > "$PID_FILE"

        # Call monitoring API
        call_monitoring_api || log_message "ERROR: Failed to reach monitoring server at $MONITORING_URL"
    else
        # Process not running, remove PID file
        [ -f "$PID_FILE" ] && rm -f "$PID_FILE"
    fi
}

# Handle termination signals
trap 'log_message "INFO: Monitoring script terminated"; exit 0' SIGTERM SIGINT

main
#!/bin/bash

# =================================================================
# Script Name: disk_usage_alert.sh
# Description: Monitors disk usage and sends an alert if it exceeds
#              a specified threshold (default 80%).
# Author:      Vijay
# =================================================================

# Set the threshold (80%)
THRESHOLD=80

echo "Checking disk usage..."
echo "------------------------------------------"

# 1. Get disk usage of all mounted filesystems
# df -Ph: Portable output format, human-readable
# grep -v: Exclude 'tmpfs' and 'cdrom' to focus on OS/Data disks
df -Ph | grep -vE '^Filesystem|tmpfs|cdrom|devtmpfs' | while read -r line; do
    
    # 2. Extract specific columns: Usage% and Partition Name
    # $5 is the percentage (e.g., 85%), $6 is the mount point
    USAGE=$(echo "$line" | awk '{print $5}' | sed 's/%//')
    PARTITION=$(echo "$line" | awk '{print $6}')

    # 3. Compare current usage with threshold
    if [ "$USAGE" -ge "$THRESHOLD" ]; then
        echo "⚠️ ALERT: Partition '$PARTITION' is at ${USAGE}%!"
        
        # Optional: Logic to send an email alert
        # echo "Disk space low on $(hostname) at ${USAGE}%" | mail -s "Disk Alert: $PARTITION" $ALERT_EMAIL
    else
        echo "✅ OK: Partition '$PARTITION' is at ${USAGE}%."
    fi
done

echo "------------------------------------------"
echo "Check complete."

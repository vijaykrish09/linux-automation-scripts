#!/bin/bash

# =================================================================
# Script Name: system_health_check.sh
# Description: Scans all critical system services and restarts
#              any that have failed.
# Author:      Vijay
# =================================================================

# Define the "Critical Services" to monitor
# You can add or remove services from this list (space separated)
SERVICES=("sshd" "crond" "nginx" "mariadb" "docker")

echo "==========================================="
echo "📊 SYSTEM HEALTH CHECK - $(date)"
echo "==========================================="

for SERVICE in "${SERVICES[@]}"; do
    # Check if the service exists on the system first
    if systemctl list-unit-files | grep -q "^$SERVICE.service"; then

        STATUS=$(systemctl is-active "$SERVICE")

        if [ "$STATUS" = "active" ]; then
            echo "✅ $SERVICE: RUNNING"
        else
            echo "❌ $SERVICE: DOWN! Attempting to recover..."
            systemctl restart "$SERVICE"

            # Verify recovery
            if [ "$(systemctl is-active "$SERVICE")" = "active" ]; then
                echo "   🚀 RECOVERED: $SERVICE is back online."
            else
                echo "   ⚠️ ALERT: $SERVICE failed to restart!"
            fi
        fi
    else
        echo "ℹ️  $SERVICE: Not installed on this server. Skipping..."
    fi
done

echo "==========================================="
echo "Check Complete."

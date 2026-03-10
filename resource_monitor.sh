#!/bin/bash

# =================================================================
# Script Name: resource_monitor.sh
# Description: Monitors CPU and Memory usage and lists the top 
#              resource-consuming processes.
# Author:     Vijay
# =================================================================

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80

echo "==========================================="
echo "🖥️  SYSTEM RESOURCE REPORT - $(date)"
echo "==========================================="

# 1. Get Current Total Usage
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

echo "Total CPU Usage: ${CPU_LOAD}%"
echo "Total Memory Usage: ${MEM_USAGE}%"
echo "-------------------------------------------"

# 2. Alert if usage is high
if (( $(echo "$CPU_LOAD > $CPU_THRESHOLD" | bc -l) )); then
    echo "⚠️  ALERT: High CPU Usage detected!"
fi

if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
    echo "⚠️  ALERT: High Memory Usage detected!"
fi

# 3. List Top 5 CPU Consuming Processes
echo "🔥 Top 5 CPU Consuming Processes:"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -n 6
echo ""

# 4. List Top 5 Memory Consuming Processes
echo "🧠 Top 5 Memory Consuming Processes:"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -n 6

echo "==========================================="

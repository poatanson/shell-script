#!/bin/bash

LOGFILE="/var/log/sys_monitor.log"
THRESHOLD_CPU=80
THRESHOLD_MEM=80
THRESHOLD_DISK=90

echo "===== $(date) =====" >> $LOGFILE

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "CPU Usage: $CPU_USAGE%" >> $LOGFILE

if (( $(echo "$CPU_USAGE > $THRESHOLD_CPU" | bc -l) )); then
  echo "[!] HIGH CPU usage detected!" >> $LOGFILE
fi

# Memory Usage
MEM_USAGE=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')
echo "Memory Usage: $MEM_USAGE%" >> $LOGFILE

if [ "$MEM_USAGE" -gt "$THRESHOLD_MEM" ]; then
  echo "[!] HIGH MEMORY usage detected!" >> $LOGFILE
fi

# Disk Usage
DISK_USAGE=$(df / | awk 'END {print $5}' | sed 's/%//')
echo "Disk Usage (/): $DISK_USAGE%" >> $LOGFILE

if [ "$DISK_USAGE" -gt "$THRESHOLD_DISK" ]; then
  echo "[!] DISK usage high!" >> $LOGFILE
fi

# Top 5 memory-hogging processes
echo "Top 5 memory consuming processes:" >> $LOGFILE
ps aux --sort=-%mem | head -n 6 >> $LOGFILE

echo "" >> $LOGFILE


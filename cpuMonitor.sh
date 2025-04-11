#!/bin/bash

THRESHOLD=80
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

CPU_INT=${CPU%.*}  # 소수점 제거 

if [ "$CPU_INT" -gt "$THRESHOLD" ]; then
	echo "[WARNING] CPU usage is above $THRESHOLD%: $CPU_INT%"
else
	echo "[OK] CPU usage is normal: $CPU_INT%"
fi

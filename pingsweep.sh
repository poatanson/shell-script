#!/bin/bash
#Simple Pingsweep script

echo "Please enter the subnet:"
read SUBNET

for IP in $(seq 1 254); do
    (ping -c 1 -w 1 $SUBNET.$IP | grep "ttl" &> /dev/null && echo "[+] Host $SUBNET.$IP is up") &
done
wait

#!/bin/bash 

TARGET="127.0.0.1"
PORTS="22 80 443 3306"

for port in $PORTS
do 
	nc -z -v -w1 $TARGET $port 2>&1 | grep -q succeeded && echo "Port $port is open"
done

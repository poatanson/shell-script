#!/bin/bash

read -p "Enter your username: " user

if [ "$user" == "admin" ]; then
	echo "Welcome, administrator."
else
	echo "Access denied for user: $user"
fi 

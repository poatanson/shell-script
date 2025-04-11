#!/bin/bash 

echo "== SUID Binaries on System =="
find / -perm -4000 -type f 2>/dev/null

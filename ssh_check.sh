#!/bin/bash

CONFIG="/etc/ssh/sshd_config"

echo "[*] SSH root 로그인 여부:"
grep "^PermitRootLogin" $CONFIG

echo "[*] 패스워드 인증 여부:"
grep "^PasswordAuthentication" $CONFIG

#!/bin/bash 

REPORT="/var/log/security_audit_$(date +%Y%m%d).log"

echo "[+] Starting security audit at $(date)" > $REPORT

# UID 0 계정 체크
echo -e "\n[+] UID 0 accounts:" >> $REPORT
awk -F: '$3 == 0 { print $1 }' /etc/passwd >> $REPORT

# SUID 파일
echo -e "\n[+] SUID Files:" >> $REPORT
find / -perm -4000 -type f 2>/dev/null >> $REPORT

# 열려있는 포트
echo -e "\n[+] Open Ports:" >> $REPORT
ss -tuln >> $REPORT

# /etc/passwd, shadow 권한
echo -e "\n[+] File Permission Check:" >> $REPORT
ls -l /etc/passwd /etc/shadow >> $REPORT

# 인증 실패 로그
echo -e "\n[+] Failed Login Attempts:" >> $REPORT
grep "Failed password" /var/log/auth.log | tail -n 5 >> $REPORT

# 크론 작업 확인
echo -e "\n[+] root Crontab:" >> $REPORT
crontab -l -u root 2>/dev/null >> $REPORT

echo -e "\n[+} Audit complete." >> $REPORT

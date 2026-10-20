#!/usr/bin/env bash

echo -e "\n=========================================="
echo "        SYSTEM HEALTH DIAGNOSTICS         "
echo -e "==========================================\n"

echo ">>> 1. RUNNING KERNEL & PACKAGE HOLDS"
echo -n "Active Kernel: " && uname -r
echo "APT Holds:"
apt-mark showhold | sed 's/^/  - /'
echo ""

echo ">>> 2. REBOOT STATUS"
# I learned today that `ls -l /var/run/reboot-required 2>/dev/null` is the terminal command
# to check if a reboot is needed. This is the bash script condition equivalent!
if [ -f /var/run/reboot-required ]; then
    echo "⚠️ REBOOT REQUIRED"
    if [ -f /var/run/reboot-required.pkgs ]; then
        echo "Packages requiring reboot:"
        cat /var/run/reboot-required.pkgs | sed 's/^/  - /'
    fi
else
    echo "✅ No reboot needed (System up-to-date in memory)"
fi
echo ""

echo ">>> 3. FAILED SYSTEM SERVICES"
systemctl --failed --no-legend || echo "All services operating normally."
echo ""

echo ">>> 4. KERNEL DRIVER STATUS (DKMS)"
dkms status || echo "No DKMS modules active."
echo ""

echo ">>> 5. STORAGE & MEMORY PRESSURE"
df -h / | awk 'NR==1 || NR==2'
echo ""
free -h
echo ""

echo ">>> 6. RECENT KERNEL ERRORS & WARNINGS (Last 10)"
# Checks kernel ring buffer for critical hardware/driver issues
sudo dmesg --level=err,warn -T | tail -n 10
echo ""

echo -e "=========================================="
echo "           DIAGNOSTIC COMPLETE            "
echo -e "==========================================\n"
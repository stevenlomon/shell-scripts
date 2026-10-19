#!/usr/bin/env bash

echo -e "\n=========================================="
echo "        SYSTEM HEALTH DIAGNOSTICS         "
echo -e "==========================================\n"

echo ">>> 1. RUNNING KERNEL & PACKAGE HOLDS"
echo -n "Active Kernel: " && uname -r
echo "APT Holds:"
apt-mark showhold | sed 's/^/  - /'
echo ""

echo ">>> 2. FAILED SYSTEM SERVICES"
systemctl --failed --no-legend || echo "All services operating normally."
echo ""

echo ">>> 3. KERNEL DRIVER STATUS (DKMS)"
dkms status || echo "No DKMS modules active."
echo ""

echo ">>> 4. STORAGE & MEMORY PRESSURE"
df -h / | awk 'NR==1 || NR==2'
echo ""
free -h
echo ""

echo ">>> 5. RECENT KERNEL ERRORS & WARNINGS (Last 10)"
# Checks kernel ring buffer for critical hardware/driver issues
sudo dmesg --level=err,warn -T | tail -n 10
echo ""

echo -e "=========================================="
echo "           DIAGNOSTIC COMPLETE            "
echo -e "==========================================\n"
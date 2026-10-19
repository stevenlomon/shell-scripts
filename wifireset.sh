#!/usr/bin/env bash

echo -e "\n=========================================="
echo "  INITIATING MEDIATEK RESET PROTOCOL      "
echo -e "==========================================\n"

echo ">>> 1. Turning off Wi-Fi radio..."
nmcli radio wifi off

echo ">>> 2. Unloading MT7921e kernel module..."
if ! sudo modprobe -r mt7921e; then
    echo "⚠️ Failed to unload mt7921e (Driver may be locked in D-state)."
    echo "   If hangs persist, a physical power capacitance drain (60s hold) is required."
fi
sleep 1

echo ">>> 3. Reloading MT7921e kernel module & unblocking radio..."
sudo modprobe mt7921e
sudo rfkill unblock wifi
sleep 1

echo ">>> 4. Restarting NetworkManager..."
sudo systemctl restart NetworkManager
nmcli radio wifi on
sleep 2

echo ">>> 5. Requesting immediate Wi-Fi network rescan..."
nmcli device wifi rescan 2>/dev/null || true

echo -e "\n=========================================="
echo "  RESET COMPLETE - Checking connection...  "
echo -e "==========================================\n"
nmcli device status | grep -E "TYPE|wifi"
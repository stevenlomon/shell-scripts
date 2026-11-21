#!/usr/bin/env bash

GAME_DIR="${1:-/home/stevenlomon/Downloads/escape-from-human-0.5.2-linuxprov-x64/escape-from-human-0.5.2-linuxprov-x64}"

if [ ! -f "$GAME_DIR/starta.sh" ]; then
    echo "⚠️ Could not find starta.sh in: $GAME_DIR"
    echo "Usage: gamingmode [/path/to/game-folder]"
    exit 1
fi

echo -e "\n=========================================="
echo "   INITIATING GAMING OPTIMIZATION MODE      "
echo -e "==========================================\n"

echo ">>> 1. Switching system power profile to Performance..."
if command -v system76-power >/dev/null 2>&1; then
    system76-power profile performance
else
    echo "⚠️ system76-power not found; skipping power profile boost."
fi

echo ">>> 2. Launching game with Radeon 840M GPU acceleration flags..."
"$GAME_DIR/starta.sh" \
    --enable-gpu-rasterization \
    --enable-zero-copy \
    --ignore-gpu-blocklist \
    --enable-features=VaapiVideoDecoder,CanvasOopRasterization

echo -e "\n=========================================="
echo "   GAME CLOSED - Restoring Balanced Mode   "
echo -e "==========================================\n"

if command -v system76-power >/dev/null 2>&1; then
    system76-power profile balanced
fi
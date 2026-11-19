#!/usr/bin/env bash

echo -e "\n=========================================="
echo "   INITIATING ALC294 MIC GAIN RESET       "
echo -e "==========================================\n"

echo ">>> 1. Setting default PipeWire audio source volume to 85%..."
if command -v wpctl >/dev/null 2>&1; then
    wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.85 || echo "⚠️ Failed to set PipeWire source volume."
else
    echo "⚠️ wpctl not found; skipping PipeWire source volume step."
fi
sleep 1

echo ">>> 2. Setting ALC294 hardware Mic Boost to 1 (+10.00 dB)..."
if ! amixer -c 1 sset 'Mic Boost' 1 >/dev/null; then
    echo "⚠️ Failed to set Mic Boost on card 1 (ALC294)."
fi

echo ">>> 3. Setting ALC294 hardware Capture to 45 (~71%)..."
if ! amixer -c 1 sset 'Capture' 45 >/dev/null; then
    echo "⚠️ Failed to set Capture volume on card 1 (ALC294)."
fi

echo -e "\n=========================================="
echo "  RESET COMPLETE - Checking mic levels...  "
echo -e "==========================================\n"
amixer -c 1 sget 'Mic Boost' | grep -E "Limits:|Front Left:"
amixer -c 1 sget 'Capture' | grep -E "Limits:|Front Left:"
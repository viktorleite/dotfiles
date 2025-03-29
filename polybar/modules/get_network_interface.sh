#!/bin/bash
INTERFACE=$(ip -o -4 route show to default 2>/dev/null | awk '{print $5}' | head -n 1)

if [ -z "$INTERFACE" ]; then
    INTERFACE=$(ls /sys/class/net | grep -E 'wlan|wlp|eth|enp' | head -n 1)
fi

echo "${INTERFACE:-lo}"

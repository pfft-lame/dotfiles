#!/usr/bin/env bash

STATE_FILE="$HOME/.local/share/battery-state"
mkdir -p "$(dirname "$STATE_FILE")"

# Find battery (BAT0 or BAT1)
BATTERY_PATH=""
if [ -d "/sys/class/power_supply/BAT0" ]; then
    BATTERY_PATH="/sys/class/power_supply/BAT0"
elif [ -d "/sys/class/power_supply/BAT1" ]; then
    BATTERY_PATH="/sys/class/power_supply/BAT1"
else
    exit 1
fi

# Get battery info
BATTERY_LEVEL=$(cat "$BATTERY_PATH/capacity" 2>/dev/null || echo "0")
BATTERY_STATUS=$(cat "$BATTERY_PATH/status" 2>/dev/null || echo "Unknown")

# Read previous state
LAST_NOTIFIED_LEVEL=""
if [ -f "$STATE_FILE" ]; then
    LAST_NOTIFIED_LEVEL=$(cat "$STATE_FILE")
fi

# Notification thresholds
LOW_BATTERY=20
CRITICAL_BATTERY=10
VERY_CRITICAL=5

# Check if battery is discharging and send notifications
if [ "$BATTERY_STATUS" = "Discharging" ]; then
    if [ "$BATTERY_LEVEL" -le "$VERY_CRITICAL" ] && [ "$LAST_NOTIFIED_LEVEL" != "very_critical" ]; then
        notify-send -u critical -i battery-caution "Critical Battery" "Battery at ${BATTERY_LEVEL}%! System will shutdown soon."
        echo "very_critical" > "$STATE_FILE"
    elif [ "$BATTERY_LEVEL" -le "$CRITICAL_BATTERY" ] && [ "$LAST_NOTIFIED_LEVEL" != "critical" ] && [ "$LAST_NOTIFIED_LEVEL" != "very_critical" ]; then
        notify-send -u critical -i battery-low "Low Battery" "Battery at ${BATTERY_LEVEL}%! Please charge immediately."
        echo "critical" > "$STATE_FILE"
    elif [ "$BATTERY_LEVEL" -le "$LOW_BATTERY" ] && [ "$LAST_NOTIFIED_LEVEL" != "low" ] && [ "$LAST_NOTIFIED_LEVEL" != "critical" ] && [ "$LAST_NOTIFIED_LEVEL" != "very_critical" ]; then
        notify-send -u normal -i battery-low "Battery Low" "Battery at ${BATTERY_LEVEL}%. Consider charging soon."
        echo "low" > "$STATE_FILE"
    fi
else
    # Reset notification state when charging/plugged in
    if [ "$BATTERY_STATUS" = "Charging" ] || [ "$BATTERY_STATUS" = "Not charging" ]; then
        echo "" > "$STATE_FILE"
    fi
fi

# Optional: Notify when fully charged
if [ "$BATTERY_STATUS" = "Not charging" ] && [ "$BATTERY_LEVEL" -ge 95 ]; then
    notify-send -u low -i battery-full "Battery Full" "Battery charged to ${BATTERY_LEVEL}%"
fi

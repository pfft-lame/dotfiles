#!/usr/bin/env bash

# Power profile toggle script for SwayNC
# Save as ~/.config/swaync/scripts/power-profile-toggle.sh

# Define profiles and their corresponding icons
declare -A PROFILES=(
    ["power-saver"]="󰌪 "      # Battery save icon  
    ["balanced"]="󰾅 "          # Balanced icon
    ["performance"]="󰓅 "       # Performance icon
)

# Get current profile
get_current_profile() {
    if command -v powerprofilesctl &> /dev/null; then
        powerprofilesctl get
    elif command -v system76-power &> /dev/null; then
        system76-power profile | grep -o 'battery\|balanced\|performance' | head -1
    else
        # Fallback - check governor
        cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo "balanced"
    fi
}

# Set power profile
set_profile() {
    local profile=$1
    
    if command -v powerprofilesctl &> /dev/null; then
        powerprofilesctl set "$profile"
    elif command -v system76-power &> /dev/null; then
        case $profile in
            "power-saver") system76-power profile battery ;;
            "balanced") system76-power profile balanced ;;
            "performance") system76-power profile performance ;;
        esac
    else
        # Fallback using cpupower or governor
        case $profile in
            "power-saver") 
                echo "powersave" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
                ;;
            "balanced") 
                echo "schedutil" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
                ;;
            "performance") 
                echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
                ;;
        esac
    fi
}

# Get next profile in cycle
get_next_profile() {
    local current=$1
    case $current in
        "power-saver") echo "balanced" ;;
        "balanced") echo "performance" ;;
        "performance") echo "power-saver" ;;
        *) echo "balanced" ;;
    esac
}

current=$(get_current_profile)
next=$(get_next_profile "$current")
set_profile "$next"
notify-send -u low -t 2000 "Power Profile" "Switched to: $next $new_icon"


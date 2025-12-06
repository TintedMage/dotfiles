# ========================================
# Tinted Hyprland
# Author: TintedMage (https://github.com/TintedMage)
# Hyprland: ~/.config/hypr/scripts/brightness.sh
# ========================================

#!/bin/bash
# Dependencies: bc, brightnessctl

# --- Configuration ---
OSD_ID="9911"  # Unique ID for mako notifications (different from volume)
STEP="5%"      # Brightness step (e.g., 5% or 10%)
DEVICE=$(brightnessctl info | awk -F "'" '/Device/ {print $2}' | head -n 1)

# Fallback device if detection fails
if [ -z "$DEVICE" ]; then
    DEVICE="intel_backlight"
fi

# --- Functions ---

# Send notification with current brightness level
send_notification() {
    BRIGHTNESS_PERCENT=$(brightnessctl -d "$DEVICE" g)
    MAX_BRIGHTNESS=$(brightnessctl -d "$DEVICE" m)
    
    # Calculate percentage (rounded to nearest integer)
    BRIGHTNESS_HINT=$(echo "$BRIGHTNESS_PERCENT * 100 / $MAX_BRIGHTNESS" | bc | awk '{print int($1+0.5)}')
    
    # Clamp hint between 0 and 100
    if [ "$BRIGHTNESS_HINT" -lt 0 ]; then BRIGHTNESS_HINT=0; fi
    if [ "$BRIGHTNESS_HINT" -gt 100 ]; then BRIGHTNESS_HINT=100; fi
    
    # Select icon based on brightness level
    if [ "$BRIGHTNESS_HINT" -eq 0 ]; then
        ICON="󰛨"
    elif [ "$BRIGHTNESS_HINT" -lt 50 ]; then
        ICON="󰃝"
    else
        ICON="󰃠"
    fi
    
    # Send notification with progress bar
    notify-send -a 'wp-brightness' \
      -h string:x-canonical-private-synchronous:brightness-osd \
      -h int:value:"$BRIGHTNESS_HINT" \
      -t 1500 \
      -i "$ICON" \
      "Brightness: $BRIGHTNESS_HINT%"
}

# --- Main Logic ---

case "$1" in
    up)
        brightnessctl -d "$DEVICE" set "$STEP"+
        send_notification
        ;;
    down)
        brightnessctl -d "$DEVICE" set "$STEP"-
        send_notification
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac
# ========================================
# Tinted Hyprland
# Author: TintedMage (https://github.com/TintedMage)
# Hyprland: ~/.config/hypr/scripts/volume.sh
# ========================================

#!/bin/bash
# Dependencies: bc, wpctl

# --- Configuration ---
OSD_ID="9910"  # Unique ID for mako notifications (different from brightness)
STEP="5%"      # Volume step (e.g., 5% or 10%)
VOL_COMMAND="wpctl"  # Use 'wpctl' for PipeWire
LIMIT_FLAG="-l 1.0"  # Limit volume to 100%

# --- Functions ---

# Send notification with current volume level and mute status
send_notification() {
    # Get raw volume and mute status
    RAW_INFO=$($VOL_COMMAND get-volume @DEFAULT_AUDIO_SINK@)
    
    # Extract volume ratio (e.g., [vol: 0.50] -> 0.50)
    VOLUME_RATIO=$(echo "$RAW_INFO" | awk '/Volume/ {print $2}')
    
    # Calculate percentage and round to nearest integer
    VOLUME_PERCENT_HINT=$(echo "scale=0; ($VOLUME_RATIO * 100) / 1" | bc)
    
    # Initialize variables
    VOLUME_DISPLAY=$VOLUME_PERCENT_HINT
    VOLUME_HINT=$VOLUME_PERCENT_HINT
    
    # Check for mute status
    if echo "$RAW_INFO" | grep -q 'MUTED'; then
        MUTE_STATUS="Mute"
        ICON="󰝟"
        VOLUME_HINT=0
        VOLUME_DISPLAY="0"
    else
        MUTE_STATUS="Volume"
        
        # Icon based on volume level
        if [ "$VOLUME_HINT" -eq 0 ]; then
            ICON="󰕿"
        elif [ "$VOLUME_HINT" -lt 33 ]; then
            ICON="󰖀"
        elif [ "$VOLUME_HINT" -lt 67 ]; then
            ICON="󰖁"
        else
            ICON="󰕾"
        fi
    fi
    
    # Send notification with progress bar
    notify-send -a 'wp-vol' -r "$OSD_ID" -t 1500 -h int:value:$VOLUME_HINT -i "$ICON" " $MUTE_STATUS: $VOLUME_DISPLAY%"
}

# --- Main Logic ---

case "$1" in
    up)
        # Increase volume by STEP, capped at 100%
        $VOL_COMMAND set-volume $LIMIT_FLAG @DEFAULT_AUDIO_SINK@ $STEP+
        send_notification
        ;;
    down)
        # Decrease volume by STEP
        $VOL_COMMAND set-volume @DEFAULT_AUDIO_SINK@ $STEP-
        send_notification
        ;;
    mute)
        # Toggle mute
        $VOL_COMMAND set-mute @DEFAULT_AUDIO_SINK@ toggle
        send_notification
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac
# ========================================
# Tinted Hyprland
# Author: TintedMage (https://github.com/TintedMage)
# Hyprland: ~/.config/hypr/scripts/power-menu.sh
# ========================================

#!/bin/bash
# Dependencies: wofi

MENU="Shutdown\nReboot\nSuspend\nLogout"

# Launch wofi and capture the user's choice
CHOICE=$(echo -e "$MENU" | wofi --dmenu --prompt "Power Menu" --width 200 --lines 5 --cache-file /dev/null)

# Execute the command based on the choice
case "$CHOICE" in
    "Logout")
        # Exit Hyprland session
        hyprctl dispatch exit
        ;;
    "Reboot")
        # Reboot the system
        systemctl reboot
        ;;
    "Shutdown")
        # Power off the system
        systemctl poweroff
        ;;
    "Suspend")
        # Suspend the system
        systemctl suspend
        ;;
    *)
        # Do nothing for escape or unknown choice
        exit 0
        ;;
esac
#!/bin/sh

# Get the current blur state
BLUR_STATE=$(hyprctl getoption decoration:blur:enabled | grep "int:" | awk '{print $2}')

if [ "$BLUR_STATE" = "1" ]; then
    # Transparency is ON, so turn it OFF
    hyprctl --batch \
        "keyword decoration:blur:enabled 0;" \
        "keyword decoration:active_opacity 1.0;" \
        "keyword decoration:inactive_opacity 1.0;"
else
    # Transparency is OFF, so turn it ON
    # 
    # --- !!! IMPORTANT !!! ---
    # Change the opacity values below to match
    # your preferred "transparent" settings.
    #
    hyprctl --batch \
        "keyword decoration:blur:enabled 1;" \
        "keyword decoration:active_opacity 0.9;" \
        "keyword decoration:inactive_opacity 0.8;"
fi

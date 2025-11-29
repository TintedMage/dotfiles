#!/bin/bash

TRIGGER_FILE="/etc/update_linuwu_sense"
PROJECT_DIR="/home/tinted/Linuwu-Sense"

# Exit immediately if the kernel wasn't updated
[ -f "$TRIGGER_FILE" ] || exit 0


cd "$PROJECT_DIR"
git pull

if sudo make install; then
    TITLE="✅ Kernel Update Post-Tasks Succeeded"
else
    TITLE="❌ Kernel Update Post-Tasks FAILED"
fi

# Delete the primary trigger file so it doesn't run next time
sudo rm -f "$TRIGGER_FILE"

touch /home/tinted/test.sh

/usr/bin/notify-send -u critical -i 'system-run' "$TITLE" "Linuwu-Sense project tasks complete."

exit 0

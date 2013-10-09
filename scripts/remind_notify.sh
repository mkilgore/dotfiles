#!/bin/bash
rem_txt=$1
if [ -n "$DISPLAY" ] && [ -n "$rem_txt" ]; then
    notify-send -u critical "Reminder:" "$rem_txt"
    # i3-nagbar -t warning -m "$rem_txt"
fi

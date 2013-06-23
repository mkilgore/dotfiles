#!/bin/bash
gksudo systemctl start smbd.service nmbd.service
if [ -n "$DISPLAY" ]; then 
  notify-send "Samba service started"
fi


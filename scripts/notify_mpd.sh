#!/bin/bash
now_play=$(ncmpcpp --now-playing '{%a - %t}|{%f}')
notify-send "MPD" "$now_play"

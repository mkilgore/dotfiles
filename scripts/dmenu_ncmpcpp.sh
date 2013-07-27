#!/bin/bash
dmenu_opt="dmenu -fn \"terminus:size=12\" "
cmd=$($dmenu_opt -p "ncmpcpp:" <&-)
tmux send-keys -t "ncmpcpp" $cmd


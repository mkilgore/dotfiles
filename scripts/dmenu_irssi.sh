#!/bin/bash
dmenu_opt="dmenu -fn \"terminus:size=10\" "
options="text\nmove\n"
cmd=$(echo -e $options | $dmenu_opt -p "Option:")
case $cmd in
  text)
    msg=$($dmenu_opt -p "Message:" <&-)
    tmux send-keys -t "irssi" "$msg" Enter
    ;;
  move)
    worksp=$($dmenu_opt -p "Window:" <&-)
    tmux send-keys -t "irssi" M-$worksp
    ;;
esac



#!/bin/bash
mpc play `mpc playlist | dmenu -b -i -nb '#040404' -nf '#525252' -sf '#ffa0ff' -sb '#000000' -h 700 -w 1000 -x 50 -y 50 -fn '-*-terminus-medium-r-*-*-16-*-*-*-*-*-*-*' -p "Find:" | cut -d')' -f1`

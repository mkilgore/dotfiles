#!/bin/bash

xsel -o | dmenu -p Calculate: | xargs echo | bc -l 2>&1 | dmenu -p Answer: | xsel -i


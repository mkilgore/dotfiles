#!/bin/bash

DMENU="dmenu -i -nb #000 -nf #7af -sb #000 -sf #fff -x 0 -y 32'"
MPD_HOST='localhost'
MPD_PORT='6600'
MUSIC_DIR=/my/music/dir/

function add_track
{
    ALBUM="$1"
    TRACK=$(echo -e "..\n$(mpc ls "$(grep "$ALBUM" /tmp/newalbum.$$ | awk -F / '{print $1}' | sort -f | uniq)/$ALBUM" | awk -F / '{print $4}')" | ${DMENU} -p "Find: " -l 30 -w 640)
    [ "${TRACK}" == ".." ] && add_album
    if [ "${TRACK}" != ".." ]
    then 
        mpc add "$(grep "${ALBUM}" /tmp/newalbum.$$ | awk -F / '{print $1}' |sort -f | uniq)/${ALBUM}/${TRACK}"
        MORE=$(echo -e "add more\nexit" | ${DMENU} -l 3 -w 100)
        [ "$MORE" == "add more" ] && add_track "${ALBUM}"    
    fi
    rm /tmp/newalbum.$$
    return
}

function add_album
{
    ALBUM=$(mpc listall | awk -F / '{print $2" - " $3}'| grep -v mp3 | sort -f | uniq | ${DMENU} -p "DmMpdC Find: " -l 30 -w 640 | sed -e 's#\ \-\ #\/#')
    echo "-${RANDOM}-"
    [ -z "$ALBUM" ] && return
    MODE=$(echo -e "add\nreplace\nopen" | ${DMENU} -l 4 -w 70)
    mpc listall | grep "$ALBUM" > /tmp/newalbum.$$
    [ $MODE == "replace" ] && mpc clear
    j=$(wc -l /tmp/newalbum.$$ | awk '{print $1}')
    J=$(( $j + 1 ))
    for ((i=1; i<J; i++))
    do
        [ $MODE == "add" -o $MODE == "replace" ] && mpc add "$( sed -n "${i}p" /tmp/newalbum.$$)" > /dev/null
    done
    [ $MODE == "open" ] && add_track "$ALBUM"
    [ $MODE == "replace" ] && mpc play 1
    rm /tmp/newalbum.$$
}

function select_track
{
    TRACK=$(mpc playlist | ${DMENU} -p "Find: " -l 30 -w 400 | cut -c 2- - | sed -r s/"\).*$"/""/)
    [ -z "$TRACK" ] && return
    MODE=$(echo -e "play\nremove" | ${DMENU} -l 2 -w 100)
    [ $MODE == "play" ] && mpc play "$TRACK"
    [ $MODE == "remove" ] &&  mpc del "$TRACK"
}

function toggle_random
{
    MRANDOM=$(mpc | grep random | awk '{print $5}')
    if [ "${MRANDOM}" == "off" ]
    then
        mpc random on
        notify-send -u low -t 1500 "MPD" "Shuffle switched on"
    else
        mpc random off
        notify-send -u low -t 1500 "MPD" "Shuffle switched off"
    fi
}

function mpd_status
{
    notify-send -u low -t 4000 "MPD" "<b>$(mpc --format '%artist% - %album% - %title%'| head -n 1)</b>
$(mpc | head -n 3 | tail -n 2)"
}

$1

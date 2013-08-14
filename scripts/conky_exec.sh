#!/bin/sh
echo "{\"version\":1}"
echo "[[]"
conky -c ~/.conky_i3bar
exit

#while [ 1 ]; do
#  conky -i 1 -c ~/.conky_i3bar
#  sleep 3
#done
#exit

#while [ 1 ]; do
#  output_text='['
#
#  xtitle=$(xgettitle)
#  if [ -n "$xtitle" ]; then
#    output_text+=" { \"full_text\" : \"$xtitle\", \"color\" : \"#999920\" } ,"
# fi 
# mpd_song=$(mpc | head -1)
# if [ -n "$mpd_song" ]; then
#   output_text+=" { \"full_text\" : \"MPD: $mpd_song\", \"color\" : \"#3388ff\" } ,"
# fi
# load_avg=$( uptime 2>/dev/null | grep 'load average:' | sed 's/.*load average: //')
# 
# output_text+=' { "full_text" : "load" , "color" : "#60da11", "separator" : false} ,'
# output_text+=" { \"full_text\" : \"$load_avg\", \"color\" : \"#5f5f5f\", \"separator\" : true} ,"
# power_out=$(acpi) 
# power_level=$(echo $power_out | cut -b 10- | grep -o '[0-9]*' )
# output_text+=" { \"full_text\" : \"$(acpi 2>/dev/null)\", \"color\" : \""
# if [[ "$power_level" -ge 50 ]]; then
#   output_text+=#60da11
# elif [[ "$power_level" -ge 20 ]]; then
#   output_text+=#b99620
# else
#   output_text+=#b90000
# fi
# 
# output_text+="\" , \"separator\" : true} ,"

# cur_time=$(date +'%a %b %d %H:%M')
# output_text+=" { \"full_text\" : \"$cur_time\"}"
# output_text+=' ] ,'
# echo $output_text
# sleep 1

#done

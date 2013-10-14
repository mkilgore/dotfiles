#!/bin/bash

h=$HOME
p=$(pwd)
declare -a old=('vim' 'vim/vimrc' 'vim/gvimrc' 'X11/Xmodmap' 'X11/Xdefaults'
'X11/xinitrc'  'bash/bashrc' 'bash/inputrc' 'i3'  'i3/i3status.conf'  'xmonad'
'tmux/tmux.conf' 'ncmpcpp'  'scripts' 'irssi' 'X11/Xresources' 'term_themes' 'ncmpcpp/config')

declare -a new=('.vim' '.vimrc'   '.gvimrc'    '.Xmodmap'    '.Xdefaults'
'.xinitrc' '.bashrc'     '.inputrc'     '.i3' '.i3status.conf'    '.xmonad'
'.tmux.conf'     '.ncmpcpp' 'scripts' '.irssi' '.Xresources' 'term_themes' '.ncmpcpprc')

# for o, n in old(@), new(@)
count=${#old[@]}
for ((i = 0; i < $count; i++))
do
  mv $h/${new[i]} $h/${new[i]}.sav
  ln -s $p/${old[i]} $h/${new[i]}
done


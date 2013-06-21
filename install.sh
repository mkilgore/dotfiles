#!/bin/bash

h=$HOME
p=$(pwd)
declare -a old=('vim' 'vim/vimrc' 'vim/gvimrc' 'X11/Xmodmap' 'Xdefaults'  'xinitrc'  'bash/bashrc' 'bash/inputrc' 'i3'  'i3/i3status.conf'  'xmonad' 'mutt/muttrc')

declare -a new=('.vim' '.vimrc'   '.gvimrc'    '.Xmodmap'    '.Xdefaults' '.xinitrc' '.bashrc'     '.inputrc'     '.i3' '.i3status.conf'    '.xmonad' '.muttrc'   )

# for o, n in old(@), new(@)
count=${#old[@]}
for ((i = 0; i < $count; i++))
do
  mv $h/${new[i]} $h/${new[i]}.sav
  ln -s $p/${old[i]} $h/${new[i]}
done


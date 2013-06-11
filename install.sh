#!/bin/bash

h=$HOME

declare -a old=('vim' 'vim/vimrc' 'vim/gvimrc' 'X11/Xmodmap' 'Xdefaults' 'bash/bashrc' 'bash/inputrc' 'i3' 'i3/i3status.conf' 'xmonad')

declare -a new=('.vim/' '.vimrc' '.gvimrc' '.Xmodmap' '.Xdefaults' '.bashrc' '.inputrc' '.i3/' '.i3/i3status.conf' '.xmonad')

# for o, n in old(@), new(@)
count=${#old[@]}
for ((i = 0; i < $count; i++))
do
  mv $h/$new[i] $h/$new[i].sav
  ln -s ./$old[i] $h/$new[i]
done
#mv $h/.vim $h/.vim.sav

#ln -s ./vim $h/.vim
#ln -s ./vim/vimrc $h/.vimrc
#ln -s ./vim/gvimrc $h/.vimrc

#ln -s ./X11/Xmodmap $h/.Xmodmap
#ln -s ./X11/Xdefaults $h/.Xdefaults

#ln -s ./bash/bashrc $h/.bashrc
#ln -s ./bash/inputrc $h/.inputrc

#ln -s ./i3 $h/.i3/
#ln -s ./i3/i3status.conf $h/.i3status.conf

#ln -s ./xmonad ./.xmonad


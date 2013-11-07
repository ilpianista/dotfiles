#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

if [ -f ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi

(pidof kded4 || kded4) &

eval $(ssh-agent)
sleep 1

ssh-add < $HOME/.kde4/Autostart/ssh-add.sh

exec awesome

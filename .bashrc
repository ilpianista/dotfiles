#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ntpsync='sudo ntpdate it.pool.ntp.org'
alias scpresume='rsync --partial --progress --rsh=ssh'
alias nopaste='pastebinit'

alias up2date='sudo pacman -Syu; echo "Checking for AUR updates..."; cower -udf'
alias asdeps='sudo pacman -S --asdeps'
alias remove='sudo pacman -Rscn'
alias useless='pacman -Qqtd'
alias sign='gpg --detach-sign --use-agent'

PS1='\[\e[0;36m\]\h \[\e[1;0m\]\W\$ '

HISTSIZE=10000
export HISTCONTROL=ignoredups

# speed-up rebuilds
export USE_CCACHE=1

export EDITOR=vim

export KDEDIRS="/usr/local:$KDEDIRS"
export PATH="$HOME/bin:$PATH"

# Use another Window Manager
#export KDEWM="awesome"

# JAVA GTK look
#export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

search() {
    pacman -Ss $1
    cower -s $1
}

scan () {
  pacman -Qlq $1 | xargs file | grep ELF | awk -F: '{print $1}' |
  while read elfobj;
    do readelf -d $elfobj | sed -n 's|.*NEEDED.*\[\(.*\)\].*|'$elfobj' -- \1|p'; done
}

# Load RVM into a shell session *as a function*
[[ -f ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ntpsync='sudo ntpdate it.pool.ntp.org'
alias bashrome='ssh bash@bash.dyndns-home.com -p 1988'
alias scpresume='rsync --partial --progress --rsh=ssh'

alias up2date='sudo pacman -Syu; cower -udf'
alias asdeps='sudo pacman -S --asdeps'
alias remove='sudo pacman -Rscn'
alias useless='pacman -Qqtd'
alias signpkg='gpg --detach-sign --use-agent'

PS1='\[\e[0;36m\]\h \[\e[1;0m\]\W\$ '

HISTSIZE=10000
export HISTCONTROL=ignoredups

# speed-up rebuilds
export USE_CCACHE=1

export EDITOR=vim

#UniBA proxy
#export {http,https,ftp}_proxy="http://wproxy.ict.uniba.it:80"

export KDEDIRS=/usr/local:/usr
export KDEHOME=~/.kde4
export PATH=~/bin:$PATH

# Use another Window Manager
#export KDEWM=awesome

# JAVA GTK look
#export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

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

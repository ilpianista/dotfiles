# User configuration

# pacman stuff
alias upgrade='sudo pacman -Syu; echo "Checking for AUR updates..."; cower -uddf'
alias asdeps='sudo pacman -S --asdeps'
alias remove='sudo pacman -Rscn'
alias useless='pacman -Qqtd'
alias makepkg='makepkg -L'

search() { pacman -Ss ${1}; cower -s ${1} }
aurpkg() { cower -d ${1}; cd /tmp/${1}; makepkg -s }

# Show needed libraries
scan() {
  pacman -Qlq ${1} | xargs file | grep ELF | awk -F: '{print $1}' |
    while read elfobj; do
    readelf -d $elfobj | sed -n 's|.*NEEDED.*\[\(.*\)\].*|'$elfobj' -- \1|p'
  done
}

# Colors for man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# YouTube
alias yt2mp3='youtube-dl -x --audio-format=mp3'
alias yt2song='youtube-dl -x'
yt2stream() { cvlc "$(youtube-dl -g ${1})" }

# useful stuff
alias dmesg='dmesg -H'
alias df='df -h'
alias du='du -ch'
alias diff='colordiff'
alias mount='mount | column -t'
alias jobs='jobs -l'
alias -g '...'='../..'
alias sign='gpg --detach-sign --use-agent'

alias uniba="export {http,https,ftp}_proxy='http://wproxy.ict.uniba.it:80'"
alias wakerome='wol 00:04:ac:65:42:1e'

alias connect='nmcli con up id'
alias disconnectiface='nmcli dev disconnect iface'
alias wifilist='nmcli dev wifi list iface wlan0'

# LS_COLORS
eval $(dircolors -b $HOME/.dir_colors)

# zplug
source /usr/share/zsh/scripts/zplug/init.zsh

zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-syntax-highlighting"

zplug "zsh-users/zsh-history-substring-search"

zplug "themes/robbyrussell", from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[kpp]}" up-line-or-history
bindkey "${terminfo[knp]}" down-line-or-history

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt APPEND_HISTORY
setopt SHARE_HISTORY

[[ -r $HOME/.config/base16-shell/scripts/base16-default-dark.sh ]] && source $HOME/.config/base16-shell/scripts/base16-default-dark.sh

# pacman stuff
alias upgrade='sudo pacman -Syu; echo "Checking for AUR updates..."; auracle sync -r'
alias asdeps='sudo pacman -S --asdeps'
alias remove='sudo pacman -Rscn'
alias useless='pacman -Qqtd'
alias makepkg='makepkg -L'

search() { pacman -Ss ${1}; auracle search ${1} }
aurpkg() { auracle download -r ${1} && cd /tmp/${1} && makepkg -s }

# Show needed libraries
scan() {
  pacman -Qlq ${1} | xargs file | grep ELF | awk -F: '{print $1}' |
    while read elfobj; do
    readelf -d $elfobj | sed -n 's|.*NEEDED.*\[\(.*\)\].*|'$elfobj' -- \1|p'
  done
}

# YouTube
alias yt2mp3='youtube-dl -x --audio-format=mp3'
alias yt2song='youtube-dl -x'
yt2stream() { vlc "$(youtube-dl -g ${1})" }

# useful stuff
alias dmesg='dmesg -H'
alias df='df -h'
alias du='du -ch'
alias diff='colordiff'
alias jobs='jobs -l'
alias ...='cd ../../'
alias rm='rm -i'
alias ls='ls --color=tty -h'
alias cp='cp -i'
alias mv='mv -i'
alias sign='gpg --armor --detach-sign'
alias cal='cal -m -3'

alias connect='nmcli con up id'
alias disconnect='nmcli con down id'
alias wifi_list='nmcli dev wifi list'

alias mount256='sudo cryptsetup luksOpen /dev/sdb1 --key-file $HOME/Documents/256-keyfile 256; /usr/bin/mount /mnt/256'
alias mount500='sudo cryptsetup luksOpen /dev/sdb1 --key-file $HOME/Documents/500-keyfile 500; /usr/bin/mount /mnt/500'
alias mount750='sudo cryptsetup luksOpen /dev/sdb1 --key-file $HOME/Documents/750-keyfile 750; /usr/bin/mount /mnt/750'

# LS_COLORS
[[ -r $HOME/.dir_colors ]] && eval $(dircolors -b $HOME/.dir_colors)

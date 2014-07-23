# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(command-not-found cp git gem history-substring-search nanoc node npm sbt sudo)

source $ZSH/oh-my-zsh.sh

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
yt2stream() { vlc "$(youtube-dl -g ${1})" }

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
alias disconnect='nmcli con down id'
alias wifilist='nmcli dev wifi list'

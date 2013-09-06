# Path to your oh-my-zsh configuration.
ZSH=/usr/share/oh-my-zsh/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git archlinux battery cp gem kate nanoc svn)

source $ZSH/oh-my-zsh.sh

# pacman stuff
alias upgrade='sudo pacman -Syu; echo "Checking for AUR updates..."; cower -uddf'
alias asdeps='sudo pacman -S --asdeps'
alias remove='sudo pacman -Rscn'
alias useless='pacman -Qqtd'
alias makepkg='makepkg -L'

search() { pacman -Ss ${1}; cower -s ${1} }

scan () {
  pacman -Qlq $1 | xargs file | grep ELF | awk -F: '{print $1}' |
    while read elfobj; do
    readelf -d $elfobj | sed -n 's|.*NEEDED.*\[\(.*\)\].*|'$elfobj' -- \1|p'
  done
}

# use my university proxy
alias uniba="export {http,https,ftp}_proxy='http://wproxy.ict.uniba.it:80'"

# useful stuff
alias sign='gpg --detach-sign --use-agent'

alias yt2mp3='youtube-dl -x --audio-format=mp3'
alias yt2song='youtube-dl -x'
yt2stream() { dragon "$(youtube-dl -g ${1})" --title "$(youtube-dl -e ${1})" }

alias dmesg='dmesg -H'
alias df='df -H'
alias du='du -ch'
alias diff='colordiff'
alias mount='mount | column -t'
alias jobs='jobs -l'
alias -g '...'='../..'

alias wakerome='wol 00:04:ac:65:42:1e'

alias weechat='python2 ~/bin/pyrnotify.py 4321 3000 & ssh -R 4321:localhost:4321 andreascarpino.it'

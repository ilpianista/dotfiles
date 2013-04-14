# pacman stuff
alias up='sudo pacman -Syu; echo "Checking for AUR updates..."; cower -udd'
alias asdeps='sudo pacman -S --asdeps'
alias remove='sudo pacman -Rscn'
alias useless='pacman -Qqtd'
alias makepkg='makepkg -L'

alias uniba="export {http,https,ftp}_proxy='http://wproxy.ict.uniba.it:80'"

alias sign='gpg --detach-sign --use-agent'

alias yt2mp3='youtube-dl -x -t --audio-format=mp3'
alias yt2song='youtube-dl -x -t'

yt2stream(){dragon "$(youtube-dl -g $1)"}

export EDITOR=vim

# Use ~/bin
export PATH="$HOME/bin:$PATH"

# RubyGems
export PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"

# Set bunlder to install rubies in $HOME
export GEM_HOME=~/.gem/ruby/2.0.0

export KDEDIRS=/usr/local:$KDEDIRS

if [ -n "$DISPLAY" ]; then
   BROWSER=rekonq
fi

export DE=kde

search() {
    pacman -Ss $1
    cower -s $1
}

scan () {
  pacman -Qlq $1 | xargs file | grep ELF | awk -F: '{print $1}' |
  while read elfobj; do
    readelf -d $elfobj | sed -n 's|.*NEEDED.*\[\(.*\)\].*|'$elfobj' -- \1|p'
  done
}

# Speed-up rebuilds
export USE_CCACHE=1
export CCACHE_DIR=/tmp/ccache
export PATH="/usr/lib/ccache/bin:$PATH"

#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

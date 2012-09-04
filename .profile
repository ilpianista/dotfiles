alias uniba="export {http,https,ftp}_proxy='http://wproxy.ict.uniba.it:80'"

alias up2date='sudo pacman -Syu; echo "Checking for AUR updates..."; cower -udf'
alias asdeps='sudo pacman -S --asdeps'
alias remove='sudo pacman -Rscn'
alias useless='pacman -Qqtd'
alias sign='gpg --detach-sign --use-agent'

export EDITOR=vim
export PATH="$HOME/bin:$PATH"
export KDEDIRS="/usr/local:$KDEDIRS"

if [ -n "$DISPLAY" ]; then
   BROWSER=rekonq
fi

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

# Speed-up rebuilds
export USE_CCACHE=1
export CCACHE_DIR=/ramdisk/ccache

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

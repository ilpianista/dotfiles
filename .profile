export EDITOR=vim

# Use ~/bin
export PATH="$HOME/bin:$PATH"

# RubyGems
export PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"

# Set bunlder to install rubies in $HOME
export GEM_HOME=~/.gem/ruby/2.0.0

export KDEDIRS=/usr/local:$KDEDIRS

if [ -n "$DISPLAY" ]; then
   export BROWSER=rekonq
fi

export DE=kde

# Speed-up rebuilds
export PATH="/usr/lib/ccache/bin:$PATH"
export CCACHE_PREFIX="distcc"
export CCACHE_DIR="/tmp/ccache"
export DISTCC_HOSTS="localhost/3"

# Java stuff
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
#export _JAVA_AWT_WM_NONREPARENTING=1

export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=' -R '

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx 2> $HOME/.xsession-errors

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
export USE_CCACHE=1
export CCACHE_PREFIX="distcc"
export CCACHE_DIR="/tmp/ccache"
export PATH="/usr/lib/ccache/bin:$PATH"
export DISTCC_HOSTS="localhost/1"

# Java stuff
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export _JAVA_AWT_WM_NONREPARENTING=1

export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS=' -R '

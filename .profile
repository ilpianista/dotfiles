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
export PATH="/usr/lib/ccache/bin:$PATH"
export DISTCC_HOSTS="localhost/1"

#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

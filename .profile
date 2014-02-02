export EDITOR=vim

# Use ~/bin
export PATH="$HOME/bin:$PATH"

# RubyGems
export PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"

# Set bunlder to install rubies in $HOME
export GEM_HOME=~/.gem/ruby/2.0.0

export KDEDIRS=/usr/local:$KDEDIRS

if [ -n "$DISPLAY" ]; then
  export BROWSER=chromium
fi

export DE=kde

# Speed-up rebuilds
export PATH="/usr/lib/ccache/bin:$PATH"
export CCACHE_PREFIX="distcc"
export CCACHE_DIR="/tmp/ccache"
export DISTCC_HOSTS="localhost/3"

export LESSOPEN="| source-highlight-esc.sh %s"
export LESS=' -R '

# Java stuff
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
export JAVA_FONTS='/usr/share/fonts/TTF'

# SSH agent
eval $(ssh-agent)

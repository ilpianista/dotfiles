export EDITOR=vim
export TERMINAL=konsole

if [ -n "$DISPLAY" ]; then
  export BROWSER=firefox
fi

# Use ~/bin
export PATH="$HOME/bin:$PATH"

# RubyGems
export PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"

# Set bunlder to install rubies in $HOME
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"

# NodeJS modules installed with npm
export PATH="$HOME/node_modules/.bin:$PATH"

# Load KDE stuff from /usr/local
export KDEDIRS=/usr/local:$KDEDIRS

# Speed-up rebuilds
export PATH="/usr/lib/ccache/bin:$PATH"
export CCACHE_PREFIX="distcc"
export CCACHE_DIR="/tmp/ccache"
export DISTCC_HOSTS="localhost/3"

# Highlighting support in less
export LESSOPEN="| source-highlight-esc.sh %s"
export LESS=' -R '

# Java fonts stuff
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true'
export JAVA_FONTS='/usr/share/fonts/TTF'

# SSH agent
eval $(ssh-agent)

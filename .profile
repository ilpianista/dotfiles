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

export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Load KDE stuff from /usr/local
export KDEDIRS="/usr/local:$KDEDIRS"

# Speed-up rebuilds
export PATH="/usr/lib/ccache/bin:$PATH"
export CCACHE_DIR="/tmp/ccache"

# Java fonts stuff
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true"
export JAVA_FONTS="/usr/share/fonts/TTF"

# SSH agent
eval $(ssh-agent)

# LS_COLORS
eval $(dircolors ~/.dir_colors)

export KDEWM=awesome

export EDITOR=vim
export TERMINAL=konsole

if [ -n "$DISPLAY" ]; then
  export BROWSER=firefox
fi

# Use ~/bin
export PATH="$HOME/bin:$PATH"

# RubyGems
export PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"

# Cabal
export PATH="$HOME/.cabal/bin:$PATH"

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

# Extra Qt styles from KDE4
#export QT_PLUGIN_PATH=/usr/local/lib/kde4/plugins:/usr/local/lib/qt/plugins/:/usr/lib/kde4/plugins/:/usr/lib/qt/plugins

#export XDG_DATA_DIRS="/usr/share:/usr/local/share"

# LS_COLORS
eval $(dircolors ~/.dir_colors)

# SSH agent
eval $(ssh-agent)

# gpg-agent
envfile="$HOME/.gnupg/gpg-agent.env"
if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
  eval "$(cat "$envfile")"
else
  eval "$(gpg-agent --daemon --write-env-file "$envfile")"
fi
export GPG_AGENT_INFO

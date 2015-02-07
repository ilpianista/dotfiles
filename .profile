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

# Load KDE4 stuff from /usr/local
export KDEDIRS="/usr/local:$KDEDIRS"
# Disable Dr Konqui
export KDE_DEBUG=1
# Will make KDebug produce colored output
export KDE_COLOR_DEBUG=1

# Equivalent of KDebug colored output for Qt5
c=`echo -e "\033"`
export QT_MESSAGE_PATTERN="%{appname}(%{pid})/(%{category}) $c\[31m%{if-debug}$c\[34m%{endif}%{function}$c\[0m: %{message}"
unset c

# Extra Qt plugins from /usr/local
export QT_PLUGIN_PATH=/usr/local/lib/qt/plugins:${QT_PLUGIN_PATH}

# Speed-up rebuilds
export PATH="/usr/lib/ccache/bin:$PATH"
export CCACHE_DIR="/tmp/ccache"

# Java fonts stuff
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true"
export JAVA_FONTS="/usr/share/fonts/TTF"

#export XDG_DATA_DIRS="/usr/local/share:/usr/share"

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

# Automatically startx
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# Use ~/bin
export PATH="$HOME/bin:$PATH"

# RubyGems
export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

# Cabal
#export PATH="$HOME/.cabal/bin:$PATH"

# Python
#export PATH="$HOME/.local/bin:$PATH"

# NodeJS modules installed with npm
export PATH="$HOME/node_modules/.bin:$PATH"

export EDITOR=vim
export TERMINAL=urxvt

if [ -n "$DISPLAY" ]; then
  export BROWSER=firefox
fi

# ZSH history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$HOME/.zsh_history"

# Disable Dr Konqui
export KDE_DEBUG=1
# Qt 5 looks for KDEHOME, https://git.reviewboard.kde.org/r/118865/
export KDEHOME="$HOME/.kde4"

# Equivalent of KDebug colored output for Qt5
c=`echo -e "\033"`
export QT_MESSAGE_PATTERN="%{appname}(%{pid})/(%{category}) ${c}[31m%{if-debug}${c}[34m%{endif}%{function}${c}[0m: %{message}"
unset c

# Colored GCC output
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# Speed-up rebuilds
export PATH="/usr/lib/ccache/bin:$PATH"
export CCACHE_DIR="/tmp/ccache"

# Java fonts stuff
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true"
export JAVA_FONTS="/usr/share/fonts/TTF"

# Bundler install gems per-user
export GEM_HOME=$(ruby -e 'print Gem.user_dir')

# KDE stuff from startkde
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export XCURSOR_THEME="breeze_cursors"
export KDE_FULL_SESSION=true
export KDE_SESSION_VERSION=5
export KDE_SESSION_UID=`id -ru`
export XDG_DATA_DIRS="/usr/share:/usr/local/share"
export XDG_CURRENT_DESKTOP="KDE"

# MPW
export MP_FULLNAME="Andrea Scarpino"

# Wayland
#export XKB_DEFAULT_LAYOUT=gb
#export QT_QPA_PLATFORM=wayland-egl
#export GDK_BACKEND=wayland

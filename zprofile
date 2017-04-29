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

# Extra Qt plugins from /usr/local
export QT_PLUGIN_PATH="/usr/local/lib/qt/plugins:${QT_PLUGIN_PATH}"

# KDE stuff
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export XCURSOR_THEME="breeze_cursors"
export KDE_FULL_SESSION=true
export KDE_SESSION_VERSION=5
export KDE_SESSION_UID=`id -ru`

export XDG_DATA_DIRS="/usr/share:/usr/local/share"
export XDG_CURRENT_DESKTOP="KDE"

# SSH Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi
export SSH_ASKPASS="/usr/bin/ksshaskpass"

# For wayland
#export XKB_DEFAULT_LAYOUT=gb
#export QT_QPA_PLATFORM=wayland-egl
#export GDK_BACKEND=wayland

# Automatically startx
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

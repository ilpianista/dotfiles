# Use ~/bin
export PATH="$HOME/bin:$PATH"

# RubyGems
export PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"

# Cabal
export PATH="$HOME/.cabal/bin:$PATH"

# NodeJS modules installed with npm
export PATH="$HOME/node_modules/.bin:$PATH"

# SSH Agent
eval $(ssh-agent)

# Automatically startx
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

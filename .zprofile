# SSH Agent
eval $(ssh-agent)

# Automatically startx
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

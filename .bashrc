#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[0;36m\]\h \[\e[1;0m\]\W\$ '

HISTSIZE=1000
export HISTCONTROL=ignoredups

[[ -f ~/.profile ]] && ~/.profile
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\033[1;32m\]\u@\h\[\033[0m\]: \[\033[1;34m\]\w\[\033[0m\]\$ '

# Set my own command
alias ls='ls --color=auto'
alias l='ls -l'
alias ll='ls -al'

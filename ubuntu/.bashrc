# If not running interactively, don't go further
[[ "$-" != *i* ]] && return

# Shell Options
alias grep='grep --color' 
alias scpresume='rsync --partial --progress -r --rsh="ssh"'
alias vi='vim'
export TERM=xterm-256color
set -o vi

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

eStyle='$'
if [ $(id -u) -eq 0 ]; then eStyle='\[\e[0;31m\]#\[\e[0m\]'; fi
PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n'"$eStyle "

# Source host specific bashrc if it exists
if [ -f "${HOME}/.bashrc_env" ] ; then
  source "${HOME}/.bashrc_env"
fi

EDITOR=vim
export EDITOR

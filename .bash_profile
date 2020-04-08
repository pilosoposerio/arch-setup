#
# ~/.bash_profile
#
#[[ -f ~/.bash_functions ]] && . ~/.bash_functions
#[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bashrc ]] && . ~/.bashrc
PATH=$PATH:/home/cp/scripts
PATH=$PATH:/home/cp/matlab-r2020a/bin
# auto start X
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi


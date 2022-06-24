# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# 背景色对应 40-47
BLACK="\[\e[30;1m\]"
RED="\[\e[31;1m\]"
GREEN="\[\e[32;1m\]"
YELLOW="\[\e[33;1m\]"
BLUE="\[\e[34;1m\]"
PURPLE="\[\e[35;1m\]"
CYAN="\[\e[36;1m\]"
WHITE="\[\e[37;1m\]"
CLEAR="\[\e[0m\]"

_PATH_="\$(pwd)"

export PS1="\[\e[37;41m\]_MY-Qcloud_$CLEAR\[\e[37;44m\]\u@\h $CLEAR $WHITE[`date "+%a %m/%d/%Y"`]$CLEAR $YELLOW$_PATH_$CLEAR\n\$ "


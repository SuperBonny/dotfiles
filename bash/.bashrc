#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
if ! hash __git_ps1 2> /dev/null; then
    source /usr/share/git/completion/git-prompt.sh
fi

PATH=$PATH:$HOME/bin

export TERM="xterm"
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export EDITOR=nano

PS1='\[\e[94m\]\A \[\e[1m\]\u\[\e[21m\e[39m\]@\[\e[2m\]\h\[\e[22m\] [\W\[\e[32m\]$(__git_ps1 " %s")\[\e[39m\]]\$ '

# Quick and dirty tweak to make aliases available under linux
alias sudo='sudo '

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'

alias vi='vim'
alias xbuild-rel="xbuild /p:Configuration=Release"
alias gputop='sudo intel_gpu_top'
alias todo='todo.sh'

if hash todo.sh 2> /dev/null; then
    printf "\e[1mWhat to do:\e[0m\n"
    todo.sh ls
    printf "\n"
fi
printf "\e[1;7m$HOSTNAME\e[0m at your commands.\n"

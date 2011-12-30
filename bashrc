# functions for parsing current git repo info
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ("${ref#refs/heads/}$(num_git_commits_ahead)")"
}

function num_git_commits_ahead {
    num=$(git status 2> /dev/null | grep "Your branch is ahead of" | awk '{split($0,a," "); print a[9];}' 2> /dev/null) || return
    if [[ "$num" != "" ]]; then
	echo "+$num"
    fi
}

# prompt setup
RED="\[\033[0;31m\]" 
YELLOW="\[\033[0;33m\]" 
GREEN="\[\033[0;32m\]"
WHITE="\[\033[0;37m\]"
PS1="[\u@\h] $GREEN\w$YELLOW\$(parse_git_branch) $GREEN\$ $WHITE"

# general environment variable setup
EDITOR=vim
PATH=./bin:/usr/local/bin:$PATH

# RVM setup
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# git bash completion
source ~/.git-completion.bash

# alias all the things
alias desk="cd ~/Desktop"
alias start_postgres="pg_ctl -D /usr/local/var/postgres9 -l /usr/local/var/postgres9/server.log start"
alias stop_postgres=" pg_ctl -D /usr/local/var/postgres9 stop -s -m fast"
alias bake="bundle exec rake"
alias gg="git grep -n $1"
alias gch="git checkout $1"
alias gpr="git pull --rebase"
alias gpoh="git push origin HEAD"

# only set vim to mvim if we're actually on OS X
[[ `uname -a` =~ "Darwin" ]] && alias vim="mvim"

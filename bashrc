alias desk="cd ~/Desktop"
if [[ `uname -a` =~ "Darwin" ]]
then
    alias emacs="open -a Emacs.app"
    alias start_mysql="sudo /usr/local/mysql/support-files/mysql.server start"
    alias stop_mysql="sudo /usr/local/mysql/support-files/mysql.server stop"
    alias restart_mysql="sudo /usr/local/mysql/support-files/mysql.server restart"
    alias vim="mvim"
    export PATH=/Library/Frameworks/Python.framework/Versions/2.6/bin/:$PATH
fi
alias gg="git grep -n $1"
alias gch="git checkout $1"
alias gpr="git pull --rebase"
alias gpoh="git push origin HEAD"


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

RED="\[\033[0;31m\]" 
YELLOW="\[\033[0;33m\]" 
GREEN="\[\033[0;32m\]"
WHITE="\[\033[0;37m\]"
PS1="[\u@\h] $GREEN\w$YELLOW\$(parse_git_branch) $GREEN\$ $WHITE"
EDITOR=emacs
PATH=./bin:$PATH:/usr/local/mysql/bin:/opt/local/lib/erlang/lib/rabbitmq_server-1.7.0/sbin/:/opt/local/lib/erlang/lib/rabbitmq_server-1.7.0/bin/:/opt/local/bin:/usr/local/git/bin:/usr/local/android-sdk/tools:/usr/local/bin
alias t=todo.sh
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home

source ~/.git-completion.bash
alias start_postgres="pg_ctl -D /usr/local/var/postgres9 -l /usr/local/var/postgres9/server.log start"
alias stop_postgres=" pg_ctl -D /usr/local/var/postgres9 stop -s -m fast"

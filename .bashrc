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
PATH=/opt/subversion/bin:$PATH:/usr/local/mysql/bin:/opt/local/lib/erlang/lib/rabbitmq_server-1.7.0/sbin/:/opt/local/lib/erlang/lib/rabbitmq_server-1.7.0/bin/:/opt/local/bin:/usr/local/git/bin:/usr/local/android-sdk/tools
alias t=todo.sh

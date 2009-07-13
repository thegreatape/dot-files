alias emacs="open -a Emacs.app"
alias src="cd ~/Code/e4x-src/stack"
alias cuervo="cd ~/Code/cuervo"
alias desk="cd ~/Desktop"
alias console="ssh thomas@console.axiomstack.seoversite.com"
alias proxy="ssh thomas@axiomstack.seoversite.com"
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
PS1="$GREEN\w$YELLOW\$(parse_git_branch) $GREEN\$ $WHITE"
EDITOR=emacs
PATH=$PATH:/usr/local/mysql/bin
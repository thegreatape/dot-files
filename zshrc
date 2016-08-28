# Path to your oh-my-zsh configuration.
ZSH=$HOME/dot-files/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="thegreatape"

# alias all the things
alias desk="cd ~/Desktop"
alias start_postgres="pg_ctl -D /usr/local/var/postgres9 -l /usr/local/var/postgres9/server.log start"
alias stop_postgres=" pg_ctl -D /usr/local/var/postgres9 stop -s -m fast"
alias bake="bundle exec rake"
alias gg="git grep --color -n $1"
alias gch="git checkout $1"
alias gpr="git pull --rebase"
alias gpoh="git push origin HEAD"
alias heroku_restore="pg_restore --verbose --clean --no-acl --no-owner"
alias git_local_cleanup="git branch --merged | grep -v \"\*\" | xargs -n 1 git branch -d"
alias emacs="TERM=xterm-256color emacs"

function track() {
  branch_name=$(git branch | grep "*");
  branch_name="${branch_name/\* /}";
  git branch --set-upstream-to=origin/$branch_name $branch_name;
}

# fuzzy git branch checkout with fzf
gco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh

# general environment variable setup
export EDITOR=vim
export PATH=~/.bin:~/dot-files/bin/:./bin:$HOME/.rbenv/bin:/usr/local/bin:$PATH
eval "$(rbenv init - --no-rehash)"

# tmuxinator setup
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# Ruby performance tweaks
export RUBY_GC_HEAP_INIT_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

# Go source path
export GOPATH=$HOME/Code/go
export PATH=~/.bin/:$PATH:$GOPATH/bin

# disable zsh autocorrect
unsetopt correct_all

# added by travis gem
[ -f /Users/tmayfield/.travis/travis.sh ] && source /Users/tmayfield/.travis/travis.sh

# vagrant ssh prefix
function v { ssh -t `cat .vname` "/bin/bash -l -c '$*'" }

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export NODE_PATH=/usr/local/lib/node_modules

export COLORTERM=xterm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setting ag as the default source for fzf
# So that fzf (w/o pipe) will use ag instead
# of find, respecting .gitignore
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

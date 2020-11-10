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
alias vim="TERM=screen-256color nvim"
alias nnvim="TERM=screen-256color ~/Code/nvim-osx64/bin/nvim"
alias ns="nix-shell --run zsh"

alias pn="note-search ~/Dropbox/Notes/Personal/"
alias wn="note-search ~/Dropbox/Notes/Work/"
alias wpn="note-search ~/Dropbox/Notes/Work-Private/"

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
    fzf-tmux -d50 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# general environment variable setup
export EDITOR=vim
export GIT_EDITOR=nvim
export PATH=~/dot-files/bin/:~/.bin:./bin:/usr/local/bin:./node_modules/.bin/:$PATH

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
unsetopt correct

# added by travis gem
[ -f /Users/thomas/.travis/travis.sh ] && source /Users/thomas/.travis/travis.sh

export NODE_PATH=/usr/local/lib/node_modules

export COLORTERM=xterm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setting ag as the default source for fzf
# So that fzf (w/o pipe) will use ag instead
# of find, respecting .gitignore
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export BBWORKSPACE="/Users/thomas/Code"

if [[ -x "$(command -v git)" && -x "$(command -v dinghy)" ]]; then
  eval $(dinghy env)
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

setopt NO_AUTOLIST BASH_AUTOLIST NO_MENUCOMPLETE

# Add aws bin to path
export PATH=~/Library/Python/3.7/bin:$PATH

# slightly less eyestraining ls colors
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LS_COLORS=$LSCOLORS

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="/usr/local/opt/ruby@2.5/bin:/usr/local/lib/ruby/gems/2.5.0/bin:$PATH"
source ~/.nix-profile/etc/profile.d/nix.sh

# wrapper for aws-vault
# usage: awsv ROLE AWSCLI-COMMAND AWSCLI-ARGS
#   e.g. `awsv ro s3 ls s3://foobucket`
function awsv () {
    local role="$1"
    shift
    aws-vault exec "$role" -- aws "$@"
}

alias aws="aws-vault exec ro -- aws"
alias aws-rw="aws-vault exec rw -- aws"
alias aws-superadmin="aws-vault exec superadmin -- aws"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

[ -f ~/.secrets.zsh ] && source ~/.secrets.zsh

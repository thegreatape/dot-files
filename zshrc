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
alias emacs="open /Applications/Emacs.app"

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# general environment variable setup
export EDITOR=vim
export PATH=~/.bin:./bin:$HOME/.rbenv/bin:/usr/local/bin:$PATH
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

# use updated ssl certs
export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt

# added by travis gem
[ -f /Users/tmayfield/.travis/travis.sh ] && source /Users/tmayfield/.travis/travis.sh

# for ssh-agent
ssh-add
unset SSL_CERT_FILE
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

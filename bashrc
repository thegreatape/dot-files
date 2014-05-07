# just here to set correct path for vim
PATH=./bin:/usr/local/bin:$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# added by travis gem
[ -f /Users/tmayfield/.travis/travis.sh ] && source /Users/tmayfield/.travis/travis.sh

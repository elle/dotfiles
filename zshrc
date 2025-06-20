# git
alias g="git"
alias gst="git status"
alias lol="git log --graph --decorate --pretty=oneline --abbrev-commit"
alias gl="git pull"
alias gp="git push"
alias gd="git diff"
alias gc="git commit -m"
alias ga="git add"
alias gm="git merge --ff-only"
alias gf="git branch --sort=committerdate"
alias gco="git checkout"
alias gr="git reset --soft HEAD^"
alias gx="gitx"
alias gpf="git push --force-with-lease"

# Finder
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -la"
alias lt="ls -lt"       # sort with recently modified first
alias rm="rm -iv"       # request confirmation when deleting files and be verbose

# Misc
alias h="history"
alias hc="/usr/bin/clear" # clears history. or is "history -c` which clears terminal but not .bash_history file
alias grep="grep --color=auto"
alias pubkey="cat ~/.ssh/*.pub |pbcopy && echo 'Keys copied to clipboard'"
alias reload="source ~/.zshrc"
alias md="macdown"
alias tree="tree -C"
alias kc="kubectl"

# Processes
alias tm="top -o csize" # memory
alias tu="top -o cpu" # cpu

# Ruby
alias gemi="gem install --no-rdoc --no-ri"

# rails
alias rep="RAILS_ENV=production"
alias res="RAILS_ENV=staging"
alias rdm="rake db:migrate && rake db:test:prepare"
alias rollback="rake db:rollback"
alias td="tail -f log/development.log"
alias ttr="touch tmp/restart.txt"
alias rlc="rake log:clear"
alias rc="rails console"
alias rs="rails server"

bindkey "^R" history-incremental-search-backward

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

export EDITOR="mvim"

# chruby specific
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Initialise colours
autoload -U colors
colors

# Allow for functions in the prompt.
setopt PROMPT_SUBST

# Quicker navigation to sub dirs in most visited dirs
setopt auto_cd
cdpath=($HOME/code)

# Make Homebrew’s completions available
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# Use modern completion system
autoload -Uz compinit
compinit

# Get the name of the branch we are on
function parse_git_branch() {
  git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/(\1) /";
}

PS1="%~ \$(parse_git_branch)\$ "

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/ems/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

. /opt/homebrew/etc/profile.d/z.sh

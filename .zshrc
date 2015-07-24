# Path to your oh-my-zsh installation.
export ZSH=/Users/chasecundiff/.oh-my-zsh
export EDITOR="VIM"

# enables shims and autocompilartion
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ssh-agent colorize copydir copyfile jump git)
alias gbv='git branch -vv'

# User configuration

export PATH="/opt/chef/embedded/bin:/opt/chefdk/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/chasecundiff/.chefdk/gem/ruby/2.1.0/bin:/Users/chasecundiff/packer:/Users/chasecundiff/apps/terraform:/Applications/Postgres.app/Contents/Versions/9.4/bin:/Users/chasecundiff/apps/liquibase"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
source /Users/chasecundiff/private/.zshrc

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias sporssh='ssh -A chase@or.b.sitesentry.co -t ssh -A'
alias bastion='ssh chase@or.bastion.sourcepoint.com'
alias ubuntu-sporssh='ssh -A ubuntu@or.b.sitesentry.co -t ssh -A'
alias start-local-flume='sudo /code/flume/bin/flume-ng agent -f /code/flume/conf/beacons.conf -c conf -n beacons --no-reload-conf -Dflume.log.dir=/var/log/flume-ng -Dflume.log.file=beacons.log'

alias ce='chef exec'

zstyle :omz:plugins:ssh-agent identities id_rsa sitesentry_oregon_sp.pem sourcepoint_nv.pem
zstyle :omz:plugins:ssh-agent identities sitesentry_oregon_sp.pem sourcepoint_nv.pem

function get-process-on-port() {lsof -n -i4TCP:$1}
function get-chef-environment() {
  knife environment show $1 --format=json > ./environments/$1.json
}

function reg-sporssh() {
  case "$1" in
    or) ssh -A chase@or.b.sitesentry.co -t ssh -A $2.$3.or.sourcepoint.com ;;
    iad) ssh -A chase@gw.iad.sourcepoint.net -t ssh -A $2.$3.iad.sourcepoint.net ;;
    sfo) ssh -A chase@sfo.bastion.sourcepoint.net -t ssh -A $2.$3.sfo.sourcepoint.net ;;
  esac
}
    

function get-chef-role() {
  knife role show $1 --format=json > ./roles/$1.json
}

function get-chef-data-bag() {
  knife data bag show $1 --format=json > ./data_bags/$1.json
}

function knife-single-host() {
  case "$1" in
    or) knife ssh $2 'sudo chef-client' --manual-list --ssh-gateway chase@or.b.sitesentry.co ;;
    iad) knife ssh $2 'sudo chef-client' --manual-list --ssh-gateway chase@gw.iad.sourcepoint.net -x chase ;;
    sfo) knife ssh $2 'sudo chef-client' --manual-list --ssh-gateway chase@sfo.bastion.sourcepoint.net -x chase ;;
  esac
}

function chefBlockBuffer() {
  case "$1" in
    va) knife-single-host va block-buffer-00$2.prod.iad.sourcepoint.com ;;
    uw1) knife-single-host uw1 block-buffer-00$2.prod.sfo.sourcepoint.com ;;
  esac
}

function chefBufferBalancer() {
  case "$1" in
    iad) knife-single-host iad buffer-balancer-00$2.$3.iad.sourcepoint.net ;;
    sfo) knife-single-host sfo buffer-balancer-00$2.$3.sfo.sourcepoint.net ;;
  esac
}

function knife-role-stage() {
  case "$1" in 
    or) knife ssh "role:$2 AND chef_environment:$3" 'sudo chef-client' --ssh-gateway chase@or.b.sitesentry.co ;;
    va) knife ssh "role:$2 AND chef_environment:$3" 'sudo chef-client' --ssh-gateway chase@va.bastion.sourcepoint.com -x chase ;;
  esac
}

function bc-stage() {
  sporssh beacon-collector-00$1.stage.or.sourcepoint.com
}

function setTabTitle() {
  echo -ne "\e]1;$1\a"
}

function getFilePermission() {
  stat -f "%OLp" $1
}

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk/Contents/Home

bindkey -v
bindkey '^r' history-incremental-search-backward
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

alias ls='ls -G'
alias d="docker"
alias dc='docker-compose'
alias dm='docker-machine'
alias tmux='tmux -2'
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
alias vim='nvim'
alias vi='nvim'

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export EDITOR=nvim
export VISUAL=nvim


function jsonprint () {
    python -mjson.tool
}

function echo-run() {
    CMD="$@"
    echo "${CMD}"
    eval "${CMD}"
}

function chpwd() {
    emulate -L zsh
    ls
}

function giphy() {
    GIF=`node ~/.scripts/giphy.js "/gif! $1"`
    if [ -z "$GIF" ]
    then
        echo "No Gif found."
    else
        open $GIF
    fi
}

PROMPT="
${_prompt_steeef_colors[5]}%~%f "'${vcs_info_msg_0_}'"
"'$python_info[virtualenv]'"$ "


source "$HOME/.homesick/repos/homeshick/homeshick.sh"

# Source local customization 
if [[ -s "${ZDOTDIR:-$HOME}/.zshcustomrc" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshcustomrc"
fi

function gi() {
    curl -L -s https://www.gitignore.io/api/$@
}

setopt IGNORE_EOF
set -o ignoreeof
bindkey '^D' beep

tic $HOME/.$TERM.ti
export PATH="/usr/local/Cellar/node/6.4.0/bin:$HOME/.local/bin:/usr/local/bin:$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export XDEBUG_CONFIG="remote_enable=1 remote_mode=req remote_port=9000 remote_host=127.0.0.1 remote_connect_back=0 idekey=PHPSTORM"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

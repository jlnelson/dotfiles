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

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export EDITOR=vim
export VISUAL=vim


function runAndReturn() {
    DIR="${PWD}"
    \cd $1 
    eval `echo "$@" | cut -d " " -f 2-`
    \cd "${DIR}"
    DIR=""
}

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

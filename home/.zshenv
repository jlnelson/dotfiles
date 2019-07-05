#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export PATH="$PATH:/Users/johnnelson/.badevops/bin"
autoload -U +X bashcompinit && bashcompinit
eval "$("/Users/johnnelson/.badevops/bin/dm" --bash-completion-script "/Users/johnnelson/.badevops/bin/dm")"
eval "$("/Users/johnnelson/.badevops/bin/dmc" --bash-completion-script "/Users/johnnelson/.badevops/bin/dmc")"

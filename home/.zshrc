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
alias n99='n98-magerun2'

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

function sanitize-m2() {
	local url="$1" 
	if [ -z "$url" ]
	then
		read "url?Base URL (example: client.dev): "
	fi
	echo "Setting up site $url..."
	n99 config:set web/unsecure/base_url "http://$url/"
	n99 config:set web/secure/base_url "http://$url/"
	n99 config:delete web/unsecure/base_link_url
	n99 config:delete web/unsecure/base_static_url
	n99 config:delete web/unsecure/base_media_url
	n99 config:delete web/secure/base_link_url
	n99 config:delete web/secure/base_static_url
	n99 config:delete web/secure/base_media_url
	echo "Setting admin path to /admin..."
	n99 config:delete admin/url/custom
	n99 config:set admin/url/use_custom 0
	n99 config:set admin/url/use_custom_path 0
	echo "Relaxing security..."
	n99 config:set admin/security/session_lifetime 86400
	n99 config:set admin/security/password_is_forced 0
	n99 config:set admin/security/password_lifetime 1000
	n99 config:set dev/template/allow_symlink 1
	echo "Turning off minification..."
	n99 config:set dev/css/merge_css_files 0
	n99 config:set dev/css/minify_files 0
	n99 config:set dev/js/enable_js_bundling 0
	n99 config:set dev/js/merge_files 0
	n99 config:set dev/js/minify_files 0
	n99 config:set dev/template/minify_html 0
	echo "Turning on js logging..."
	n99 config:set dev/js/session_storage_logging 1
	n99 config:delete web/cookie/cookie_domain
	n99 config:delete web/cookie/cookie_path
	echo "Setting search engine to mysql..."
	n99 config:set catalog/search/engine mysql
	echo "Creating admin user..."
	n99 admin:user:delete admin
	n99 admin:user:create --admin-user="admin" --admin-password="pass4admin" --admin-email="admin@blueacorn.com" --admin-firstname="Admin" --admin-lastname="Admin"
	echo "Flushing cache..."
	n99 cache:clean
	n99 cache:flush
}

function sanitize-m1() {
    BASE_URL="http://$1/";
    n98-magerun db:query "update core_config_data set value = '$BASE_URL' where path = 'web/unsecure/base_url';"
    n98-magerun db:query "update core_config_data set value = '$BASE_URL' where path = 'web/secure/base_url';"
    n98-magerun db:query "update core_config_data set value = '0' where path = 'payment/authorizenet/active';"
    n98-magerun db:query "update core_config_data set value = '1' where path = 'payment/ccsave/active';"
    n98-magerun db:query "delete from core_config_data where path = 'web/cookie/cookie_domain';"
    n98-magerun db:query "update core_config_data set value = '0' where path = 'dev/js/merge_files';"
    n98-magerun db:query "update core_config_data set value = '0' where path = 'dev/css/merge_files';"
    n98-magerun db:query "update core_config_data set value = '{{unsecure_base_url}}' where path = 'web/unsecure/base_link_url';"
    n98-magerun db:query "update core_config_data set value = '{{unsecure_base_url}}skin/' where path = 'web/unsecure/base_skin_url';"
    n98-magerun db:query "update core_config_data set value = '{{unsecure_base_url}}media/' where path = 'web/unsecure/base_media_url';"
    n98-magerun db:query "update core_config_data set value = '{{unsecure_base_url}}js/' where path = 'web/unsecure/base_js_url';"
    n98-magerun db:query "update core_config_data set value = '{{secure_base_url}}' where path = 'web/secure/base_link_url';"
    n98-magerun db:query "update core_config_data set value = '{{secure_base_url}}skin/' where path = 'web/secure/base_skin_url';"
    n98-magerun db:query "update core_config_data set value = '{{secure_base_url}}media/' where path = 'web/secure/base_media_url';"
    n98-magerun db:query "update core_config_data set value = '{{secure_base_url}}js/' where path = 'web/secure/base_js_url';"
    n98-magerun db:query "update core_config_data set value = '0' where path = 'admin/security/password_is_forced';"
    n98-magerun db:query "update core_config_data set value = '1000' where path = 'admin/security/password_lifetime';"
    n98-magerun db:query "update core_config_data set value = '86400' where path = 'admin/security/session_cookie_lifetime';"
    n98-magerun config:set admin/security/session_cookie_lifetime 86400
    n98-magerun.phar admin:user:create "admin" t@t.com "pass4admin" t s
    n98-magerun config:set admin/startup/page 'system/config'
    n98-magerun config:set dev/log/active 1
}

setopt IGNORE_EOF
set -o ignoreeof
bindkey '^D' beep

tic $HOME/.$TERM.ti
export GIPHY_API_KEY="dc6zaTOxFJmzC"
export PATH="/usr/local/Cellar/node/6.4.0/bin:$HOME/.local/bin:/usr/local/bin:$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export XDEBUG_CONFIG="remote_enable=1 remote_mode=req remote_port=9000 remote_host=127.0.0.1 remote_connect_back=0 idekey=PHPSTORM"
export NVM_DIR="$HOME/.nvm"
export RELEASE_OAUTH_TOKEN="c7945f11706c76e5781580939c4fe28de18fde13"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/johnnelson/.nvm/versions/node/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/johnnelson/.nvm/versions/node/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/johnnelson/.nvm/versions/node/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/johnnelson/.nvm/versions/node/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/johnnelson/.nvm/versions/node/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/johnnelson/.nvm/versions/node/v8.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh
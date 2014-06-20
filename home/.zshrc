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

# Customize to your needs...
#
export MW_HOME=/Applications/Weblogic
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export JAVA_OPTIONS="-Xms512m -Xmx1024m -XX:MaxPermSize=1024m"
export _JAVA_OPTIONS=$JAVA_OPTIONS
export USER_MEM_OPTIONS=$JAVA_OPTIONS
export CATALINA_HOME=/usr/local/apache-tomcat
export LOGGING_CONFIG="-Djava.util.logging.config.file=$CATALINA_HOME/conf/log4j.xml"
export JPDA_ADDRESS=8009
export JPDA_TRANSPORT=dt_socket

export REL_BRANCH=2014.2.JCT

export PATH=/opt/subversion/bin:$CATALINA_HOME/bin:/usr/local/lib/node_modules:$PATH
#export DYLD_LIBRARY_PATH=/opt/subversion/lib:/usr/lib:$DYLD_LIBRARY_PATH
export MAVEN_OPTS="-Xmx1024 -XX:MaxPermSize=128m -XX:+CMSClassUnloadingEnabled -XX:+CMSPermGenSweepingEnabled"

export ENTERPRISE_SCHEMAS=/Users/jnelson/Projects/enterpriseServices/trunk/enterpriseSchemas
export BENEFITFOCUS_API=/Users/jnelson/Projects/enterpriseServices/trunk/schemas/benefitfocus-api
export PLATFORM_SERVICES_FRAMEWORK=/Users/jnelson/Projects/enterpriseServices/trunk/platform-services-framework
export ENROLLMENT_CBM=/Users/jnelson/Projects/enrollment/trunk/4X/cbm/bf-enrollment-cbm
export ENROLLMENT_SERVICES=/Users/jnelson/Projects/enrollment/trunk/4X/cbm/bf-enrollment-services
export PLATFORMSERVICES_WEB=/Users/jnelson/Projects/enrollment/trunk/4X/webservices/platformservices/platformservices-web

export ENTERPRISE_SCHEMAS_REL=/Users/jnelson/Projects/enterpriseServices/branches/$REL_BRANCH/enterpriseSchemas
export BENEFITFOCUS_API_REL=/Users/jnelson/Projects/enterpriseServices/branches/$REL_BRANCH/schemas/benefitfocus-api
export PLATFORM_SERVICES_FRAMEWORK_REL=/Users/jnelson/Projects/enterpriseServices/branches/$REL_BRANCH/platform-services-framework
export ENROLLMENT_CBM_REL=/Users/jnelson/Projects/enrollment/branches/$REL_BRANCH/4X/cbm/bf-enrollment-cbm
export ENROLLMENT_SERVICES_REL=/Users/jnelson/Projects/enrollment/branches/$REL_BRANCH/4X/cbm/bf-enrollment-services
export PLATFORMSERVICES_WEB_REL=/Users/jnelson/Projects/enrollment/branches/$REL_BRANCH/4X/webservices/platformservices/platformservices-web

export GROUPSHOPPING_HOME=/Users/jnelson/workspace/svn/GroupShopping
export THRESHER_HOME=/Users/jnelson/Projects/thresher

export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2375

alias mci="mvn -DskipTests=true clean install"
alias vim="mvim -v"
alias sudo="adminRun"
alias ls='ls -G'

export PATH=/opt/local/bin:/opt/local/sbin:$PATH

function adminRun() {
    su JohnNadmin -c "sudo $@"
}

function cpgs() {
    \cp -f /Users/jnelson/Projects/gs-ui/dist/compiled/* /Users/jnelson/Projects/mdd-engine/dist/compiled
}

function cgs() {
     DIR="${PWD}"
     cd /Users/jnelson/Projects/gs-ui
     grunt dist
     cpgs
     cd "${DIR}"
     DIR=""
}

function cmdd() {
     DIR="${PWD}"
     cd /Users/jnelson/Projects/mdd-engine
     grunt dist
     cd "${DIR}"
     DIR=""
} 

function gsrel() {
    clean-install "${ENROLLMENT_CBM_REL}" &&
    clean-install "${ENROLLMENT_SERVICES_REL}" &&
    clean-install "${PLATFORMSERVICES_WEB_REL}"
}

function buildEnrol() {
    clean-install "${ENTERPRISE_SCHEMAS}" &&
    clean-install "${BENEFITFOCUS_API}" &&
    clean-install "${PLATFORM_SERVICES_FRAMEWORK}" &&
    clean-install "${ENROLLMENT_CBM}" &&
    clean-install "${ENROLLMENT_SERVICES}" &&
    clean-install "${PLATFORMSERVICES_WEB}"
}

function gsmongo() {
    proc=$(psfind mongo)
    if [ "$proc" == "" ]; then
        mongod --fork --dbpath $HOME/mongodb/groupshopping/data --logpath $HOME/mongodb/groupshopping/logs --logappend
    else
        mongo groupshopping $*
    fi
}

function gsup () {
    DIR="${PWD}"
    cd "${GROUPSHOPPING_HOME}" 
    echo-run "svn update"
    cd "${DIR}"
}

function startthresh () {
    DIR="${PWD}"
    cd "${THRESHER_HOME}" 
    echo-run "pm2 kill mdd"
    echo-run "pm2 start config/local.json"

    cd "${DIR}"
}

function jsonprint () {
    python -mjson.tool
}

function gsmongoboot () {
    eval "mongo localhost/groupshopping ${GROUPSHOPPING_HOME}/devLocal.env.js ${GROUPSHOPPING_HOME}/bootstrap.js ${GROUPSHOPPING_HOME}/serviceDetails.js ${GROUPSHOPPING_HOME}/gsBeanProperties.js"
}

function echo-run() {
    CMD="$@"
    echo "${CMD}"
    eval "${CMD}"
}

# maven clean install with parameter for directory to do it in.
function clean-install() {
    DIR="$1"
    if [ ! -z "${DIR}" ]
    then
cd "${DIR}"
    fi
    echo-run "mci"
}

function chpwd() {
    emulate -L zsh
    ls
}

[ -s "/Users/jnelson/.nvm/nvm.sh" ] && . "/Users/jnelson/.nvm/nvm.sh" # This loads nvm

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
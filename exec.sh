#!/usr/bin/env bash

#Script DIF
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "${DIR}/build"

#this script filename
me=$(basename "$0")

EXEC_CMD=${me}

set -o nounset -o pipefail -o errexit

if [[ -f "$DIR/build/.env" ]]; then
    # Load all variables from .env and export them all for script to read
    set -o allexport
    source "$DIR/build/.env"
    set +o allexport
fi

#@TODO: move to separate file
hlp() {
    if [[ -z ${1+x} ]]; then
        echo -e "${Yellow}Usage:${Cyan}"
        echo -e "${me} build-site"
        echo "${me} run {ARGS}"
        echo "${me} test {ARGS}"
        echo "${me} run-in {ARGS}"
        echo "${me} exec {ARGS}"
        echo "${me} compass"
        echo "${me} {ARGS}"
        echo "${me} help"
    else
        case "$1" in
            build-site)
                prnt "${BASE_CMD_RUN} php-dev ansible-playbook ../build/build.yml {ARGS} - run ansible build in dev container"
                ;;

            run)
                prnt "${BASE_CMD_RUN} php-dev {ARGS} - run command in dev container"
                ;;

            test)
               prnt "${BASE_CMD_RUN} codecept codecept run {ARGS} --html --xml - run tests in codeception container"
               ;;

            run-in)
               prnt "${BASE_CMD_RUN} {CONTAINER_NAME} {ARGS} - in specific container"
               ;;

            exec)
               prnt "${BASE_CMD} exec {CONTAINER_NAME} {ARGS} - in specific container"
               ;;

            compass)
               prnt "${BASE_CMD_RUN} compass watch"
               ;;

            help)
                echo "Run this help"
                ;;
            *)
                echo "default action"
                ;;
        esac
    fi
}

#@TODO: move to separate file
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
prnt() {
    echo -e "${Blue}Running: ${Yellow}${@:1}${Color_Off}"
}


if [ "$#" -lt 1 ]; then
  hlp
  exit 0
fi

#ADD COMPOSE_CMD to .env file to override
if [[ -z ${COMPOSE_CMD+x} ]]; then
    COMPOSE_CMD="-f docker-compose.${D_ENV}.yml"
fi

BASE_CMD="docker-compose $COMPOSE_CMD"

BASE_CMD_RUN="${BASE_CMD} run --rm"

if [[ -z ${1+x} ]]; then
  hlp
elif test -f "${DIR}/scripts/${1}.sh"; then
    source "${DIR}/scripts/${1}.sh" ${@:2}
elif [[ ! -z ${2+x} && $2 = '--help' ]]; then
    hlp $1
else
    case "$1" in
        build-site)
            prnt "Build site (${BASE_CMD_RUN} php-dev ansible-playbook /app/build/build.yml ${@:2})"
            ${BASE_CMD_RUN} php-dev ansible-playbook /app/build/build.yml ${@:2}
            ;;
        ansible)
            prnt "Build site (${BASE_CMD_RUN} php-dev ansible-playbook /app/build/${2}.yml ${@:3})"
            ${BASE_CMD_RUN} php-dev ansible-playbook /app/build/${2}.yml ${@:3}
            ;;
        run)
            prnt "${BASE_CMD_RUN} php-dev ${@:2}"
             ${BASE_CMD_RUN} php-dev ${@:2}
            ;;

        test)
           prnt "${BASE_CMD_RUN} codecept codecept run ${@:2} --html --xml"
           ${BASE_CMD_RUN} codecept codecept clean
           ${BASE_CMD_RUN} codecept codecept run ${@:2} --html --xml
           ;;

        run-in)
           prnt "${BASE_CMD_RUN} $2 ${@:3}"
           ${BASE_CMD_RUN} $2 ${@:3}
           ;;

        exec)
           prnt "${BASE_CMD} exec $2 ${@:3}"
           ${BASE_CMD} exec $2 ${@:3}
           ;;

        help)
           hlp
           ;;

        *)
           prnt "${BASE_CMD} ${@:1}"
           ${BASE_CMD} ${@:1}
    esac
fi

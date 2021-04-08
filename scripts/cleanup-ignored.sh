#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
prnt "CLEANUP: git clean -xdf"
cd "${DIR}/app"
set -x

git clean -xdf
rm -Rf web/modules
rm -Rf web/profiles
rm -Rf vendor
rm -Rf web/sites

#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x
if [[ -z $1 ]]; then
  echo "Missing branch/tag name"
  exit
fi
cd "${DIR}"

sudo chown -Rf $(id -u):$(id -g) "${DIR}"

./${EXEC_CMD} cleanup-ignored

cd "${DIR}/app"

git clean -fdx

git checkout -- .
git fetch
git checkout $1
rm -f composer.lock

cd "${DIR}"
./${EXEC_CMD} ansible build-profile
./${EXEC_CMD} dist
./${EXEC_CMD} run drush cr
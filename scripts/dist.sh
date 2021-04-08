#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x

cd "${DIR}"
chmod a+w app/web/sites/default/ -Rf
./${EXEC_CMD} run composer install --no-interaction -vvv

./${EXEC_CMD} npm-theme install
./${EXEC_CMD} gulp-theme clean
./${EXEC_CMD} gulp-theme dist

./${EXEC_CMD} npm-subtheme install
./${EXEC_CMD} gulp-subtheme clean
./${EXEC_CMD} gulp-subtheme dist

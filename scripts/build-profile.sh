#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x

cd "${DIR}"
./${EXEC_CMD} ansible build-profile

./${EXEC_CMD} npm-theme install
./${EXEC_CMD} gulp-theme debug
./${EXEC_CMD} gulp-theme clean
./${EXEC_CMD} gulp-theme compile

./${EXEC_CMD} npm-subtheme install
./${EXEC_CMD} gulp-subtheme debug
./${EXEC_CMD} gulp-subtheme clean
./${EXEC_CMD} gulp-subtheme compile

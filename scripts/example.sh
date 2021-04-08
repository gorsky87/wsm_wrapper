#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x

echo "${BASE_CMD_RUN}"

# cd "${DIR}/app"
# ./${EXEC_CMD} run composer install --no-interaction -vvv
# ./${EXEC_CMD} npm-theme install
# ./${EXEC_CMD} ansible build-profile
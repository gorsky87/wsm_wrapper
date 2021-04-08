#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x

cd "${DIR}/build"
${BASE_CMD_RUN} -w /var/www/web/themes/custom/droopler_subtheme gulp npm ${@:1}
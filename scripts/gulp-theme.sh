#!/bin/bash
if [[ -z ${BASE_CMD_RUN} ]]; then
  me=$(basename "$0")
  echo "run command from ./exec.sh:";
  echo "./exec.sh ${me%.*}"
fi
set -e
set -x

cd "${DIR}/build"
${BASE_CMD_RUN} -w /var/www/web/profiles/contrib/droopler/themes/custom/droopler_theme gulp gulp ${@:1}
